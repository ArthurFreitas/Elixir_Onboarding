defmodule Ims.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :SKU
    field :description
    field :name
    field :price, :float
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:SKU, :name, :description, :quantity, :price])
    |> validate_required([:SKU, :name, :description, :quantity, :price])
  end
end
