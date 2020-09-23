defmodule Ims.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:SKU, :description, :name, :price, :quantity, :id, :barcode]}
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field :SKU
    field :description
    field :name
    field :barcode, :string, default: "00000000"
    field :price, :float, default: 0
    field :quantity, :integer
  end

  def create(attrs) do
    %Ims.Product{}
    |> changeset(attrs)
  end
  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:SKU, :name, :description, :quantity, :price, :barcode])
    |> validate_required([:SKU, :name])
    |> validate_number(:price, greater_than: 0)
    |> validate_format(:SKU, ~r/^[a-zA-Z0-9\-]+$/)
    |> validate_format(:barcode, ~r/^[0-9]+$/)
    |> validate_length(:barcode, min: 8, max: 13)
  end

  def from_json(json) do
    Poison.decode(json, as: %Ims.Product{})
  end
end
