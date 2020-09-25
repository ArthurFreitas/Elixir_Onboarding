defmodule Ims.ProductHelper do
  import Ecto.Query, warn: false
  alias Ims.Repo
  alias Ims.Product

  @redis_helper Application.get_env(:ims, :redis_helper)

  def list do
    Repo.all(Product)
  end

  def get(id) do
    with {:error, _} <- @redis_helper.get(id),
      %Product{} = product <- Repo.get(Product, id) do
        @redis_helper.set(product)
        {:ok, product}
      else
        {:ok, json} ->
          Product.from_json(json)
        _ ->
          {:error, :not_found}
    end
  end

  def insert(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Product{} = product, attrs) do
    @redis_helper.del(product)
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete(id) when is_bitstring(id) do
    Repo.get(Product,id)
    |> delete
  end

  def delete(%Product{} = product) do
    @redis_helper.del(product)
    Repo.delete(product)
  end
end
