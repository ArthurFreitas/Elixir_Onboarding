defmodule Ims.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:SKU, :description, :name, :price, :quantity, :id]}
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field :SKU
    field :description
    field :name
    field :price, :float
    field :quantity, :integer
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:SKU, :name, :description, :quantity, :price])
    |> validate_required([:SKU, :name, :description, :quantity, :price])
  end

  def from_json(json) do
    Poison.decode(json, as: %Ims.Product{})
  end
end
