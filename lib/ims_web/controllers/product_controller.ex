defmodule ImsWeb.ProductController do
  use ImsWeb, :controller
  alias Ims.ProductHelper
  alias Ims.Product
  alias Ims.RedisHelper
  alias Ims.ElasticSearchHelper

  def index(conn, _params) do
    render(conn, :list, products: ProductHelper.list)
  end

  def show(conn, %{"id" => id}) do
    product = handleProductQuery(conn, id)
    ElasticSearchHelper.post(:product, :show, conn, product)
    render(conn, :show, id: id, product: product)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{}, %{})
    ElasticSearchHelper.post(:product, :new, conn)
    render(conn, :new, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    RedisHelper.del(id)
    product = handleProductQuery(conn, id)
    changeset = Product.changeset(product,%{})
    ElasticSearchHelper.post(:product, :edit, conn, product)
    render(conn, :edit, changeset: changeset, product: product)
  end

  def create(conn, %{"product" => product}) do
    ProductHelper.insert(product)
    ElasticSearchHelper.post(:product, :create, conn, product)
    redirectToIndex(conn)
  end

  def update(conn, %{"id" => id, "product" => updatedProduct}) do
    product = handleProductQuery(conn, id)
    ProductHelper.update(product, updatedProduct)
    ElasticSearchHelper.post(:product, :update, conn, product)
    redirectToIndex(conn)
  end

  def destroy(conn, %{"id" => id} = idMap) do
    ProductHelper.delete(id)
    ElasticSearchHelper.post(:product, :destroy, conn, idMap)
    redirectToIndex(conn)
  end

  def missing(conn, _params) do
    render(conn, :missing)
  end

  defp redirectToIndex(conn) do
    conn |> redirect(to: "/product") |> halt()
  end

  defp handleProductQuery(conn, id) do
    case ProductHelper.get(id) do
      {:ok, product} -> product
      {:error, _} -> showMissingProductPage(conn)
    end
  end

  defp showMissingProductPage(conn) do
    conn |> redirect(to: "/product/missing") |> halt()
  end
end
