defmodule Ims.ProductHelper do
  import Ecto.Query, warn: false
  alias Ims.Repo
  alias Ims.Product
  alias Ims.RedisHelper

  def list do
    Repo.all(Product)
  end

  def get(id) do
    with {:error, _} <- RedisHelper.get(id),
      %Product{} = product <- Repo.get(Product, id) do
        RedisHelper.set(product)
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
    RedisHelper.del(product)
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete(id) when is_bitstring(id) do
    {:ok, product} = get(id)
    delete(product)
  end

  def delete(%Product{} = product) do
    RedisHelper.del(product)
    Repo.delete(product)
  end
end
