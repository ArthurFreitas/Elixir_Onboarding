defmodule ImsWeb.ProductTest do
  use Ims.DataCase

  # :SKU
  #   field :description
  #   field :name
  #   field :price, :float
  #   field :quantity, :integer

  @valid_product %Ims.Product{
    SKU: "AbC-12",
    name: "Abacate",
    price: 15.0,
    barcode: "12345678"
  }

  test "a valid product should have no errors" do
    assert [] = Ims.Product.changeset(@valid_product, %{}).errors
  end
end
