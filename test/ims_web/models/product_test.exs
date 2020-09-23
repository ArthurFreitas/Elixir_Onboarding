defmodule ImsWeb.ProductTest do
  use Ims.DataCase
  alias Ims.Product

  # :SKU
  #   field :description
  #   field :name
  #   field :price, :float
  #   field :quantity, :integer

  @valid_product_attrs %{
    SKU: "AbC-12",
    name: "Abacate",
    price: 15.0,
    barcode: "12345678"
  }

  test "a valid product should have no errors" do
    assert  [] = Product.create(@valid_product_attrs).errors
  end

  test "name is a required product field" do
    changeset = @valid_product_attrs
    |> Map.delete(:name)
    |> Product.create()

    assert "can't be blank" in errors_on(changeset).name
  end

  test "price is greater than zero" do
    changeset = @valid_product_attrs
    |> Map.put(:price, -1.0)
    |> Product.create()

    assert "must be greater than 0" in errors_on(changeset).price
  end
end
