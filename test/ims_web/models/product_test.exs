defmodule ImsWeb.ProductTest do
  use Ims.DataCase
  alias Ims.Product

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

  test "SKU should have only letters, numbers and hyphen" do
    changeset = @valid_product_attrs
    |> Map.put(:SKU, "1@~;")
    |> Product.create()

    assert "has invalid format" in errors_on(changeset).'SKU'
  end

  test "barcode should have more than 8 and less than 13 digits" do
    changeset = @valid_product_attrs
    |> Map.put(:barcode, "1234567a")
    |> Product.create()
    assert "has invalid format" in errors_on(changeset).barcode

    changeset = @valid_product_attrs
    |> Map.put(:barcode, "1234567")
    |> Product.create()
    assert "should be at least 8 character(s)" in errors_on(changeset).barcode

    changeset = @valid_product_attrs
    |> Map.put(:barcode, "12345678901234")
    |> Product.create()
    assert "should be at most 13 character(s)" in errors_on(changeset).barcode
  end

  test "price should default to zero" do
    assert 0 = %Product{}.price
  end
end
