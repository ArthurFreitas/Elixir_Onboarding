defmodule ImsWeb.ProductTest do
  use Ims.DataCase, async: true
  alias Ims.Product

  @valid_product_attrs %{
    SKU: "AbC-12",
    name: "Abacate",
    price: 15.0,
    barcode: "12345678"
  }

  describe "A valid product" do
    test "has no validation errors" do
      assert  [] = Product.changeset(@valid_product_attrs).errors
    end

    test "always has a name" do
      changeset = @valid_product_attrs
      |> Map.delete(:name)
      |> Product.changeset()

      assert "can't be blank" in errors_on(changeset).name
    end

    test "has a price that is greater than zero" do
      changeset = @valid_product_attrs
      |> Map.put(:price, -1.0)
      |> Product.changeset()

      assert "must be greater than 0" in errors_on(changeset).price
    end

    test "has a SKU with only letters, numbers and hyphens" do
      changeset = @valid_product_attrs
      |> Map.put(:SKU, "1@~;")
      |> Product.changeset()

      assert "has invalid format" in errors_on(changeset).'SKU'
    end

    test "has a barcode with more than 8 and less than 13 digits" do
      changeset = @valid_product_attrs
      |> Map.put(:barcode, "1234567a")
      |> Product.changeset()
      assert "has invalid format" in errors_on(changeset).barcode

      changeset = @valid_product_attrs
      |> Map.put(:barcode, "1234567")
      |> Product.changeset()
      assert "should be at least 8 character(s)" in errors_on(changeset).barcode

      changeset = @valid_product_attrs
      |> Map.put(:barcode, "12345678901234")
      |> Product.changeset()
      assert "should be at most 13 character(s)" in errors_on(changeset).barcode
    end

    test "has a price field that defaults to zero" do
      assert 0 = %Product{}.price
    end

    test "has a barcode field that defaults to 00000000" do
      assert "00000000" = %Product{}.barcode
    end
  end
end
