defmodule Ims.ProductHelper do
  import Ecto.Query, warn: false
  alias Ims.Repo
  alias Ims.Product

  def list do
    Repo.all(Product)
  end

  def get!(id) do
    Repo.get!(Product, id)
  end

  def insert(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Product{} = product, attrs) do
    product
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete(id) when is_bitstring(id)do
    product = get!(id)
    delete(product)
  end

  def delete(%Product{} = product) do
    Repo.delete(product)
  end
end
