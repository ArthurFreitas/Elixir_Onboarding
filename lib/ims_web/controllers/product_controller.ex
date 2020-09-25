defmodule ImsWeb.ProductController do
  use ImsWeb, :controller
  alias Ims.ProductHelper
  alias Ims.Product

  @redis_helper Application.get_env(:ims, :redis_helper)
  @elastic_search_helper Application.get_env(:ims, :elastic_search_helper)

  def index(conn, _params) do
    render(conn, :list, products: ProductHelper.list)
  end

  def show(conn, %{"id" => id}) do
    case ProductHelper.get(id) do
      {:ok, %Product{} = product} ->
        @elastic_search_helper.post(:product, :show, conn, product)
        render(conn, :show, id: id, product: product)
      {:error, _} -> missing(conn)
    end
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{}, %{})
    @elastic_search_helper.post(:product, :new, conn)
    render(conn, :new, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    @redis_helper.del(id)
    case ProductHelper.get(id) do
      {:ok, %Product{} = product} ->
        changeset = Product.changeset(product,%{})
        @elastic_search_helper.post(:product, :edit, conn, product)
        render(conn, :edit, changeset: changeset, product: product)
      {:error,_} -> missing(conn)
    end
  end

  def create(conn, %{"product" => product}) do
    case ProductHelper.insert(product) do
      {:ok, _product} ->
        @elastic_search_helper.post(:product, :create, conn, product)
        redirectToIndex(conn)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "product" => updatedProduct}) do
    with  {:ok, %Product{} = product} <- ProductHelper.get(id),
          {:ok, updatedProduct} <- ProductHelper.update(product, updatedProduct) do
            @elastic_search_helper.post(:product, :update, conn, updatedProduct)
            redirectToIndex(conn)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, changeset: changeset, product: %Product{id: id})
      {:error, _} ->
        missing(conn)
    end
  end

  def destroy(conn, %{"id" => id} = idMap) do
    case ProductHelper.get(id) do
      {:ok, %Product{} = product} ->
        ProductHelper.delete(product)
        @elastic_search_helper.post(:product, :destroy, conn, idMap)
        redirectToIndex(conn)
      {:error, _} -> missing(conn)
    end
  end

  def missing(conn, _params\\ nil) do
    conn
    |> put_status(404)
    |> render(:missing)
  end

  defp redirectToIndex(conn) do
    conn |> redirect(to: "/product") |> halt()
  end
end
