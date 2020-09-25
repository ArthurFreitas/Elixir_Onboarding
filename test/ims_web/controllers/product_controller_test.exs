defmodule ImsWeb.ProductControllerTest do
  use ExUnit.Case, async: false
  use Ims.DataCase, async: false
  use ImsWeb.ConnCase

  @moduletag :integration

  @valid_product_attrs %{
    SKU: "AbC-12",
    name: "Abacate",
    price: 15.0,
    barcode: "12345678"
  }

  describe "index" do
    test "redirects to stock page", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))

      assert html_response(conn, 200) =~ "Stock"
    end
  end

  describe "create product" do
    test "redirects to index and lists new product", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @valid_product_attrs)

      assert redirected_to(conn) == "/product"

      conn = get(conn, Routes.product_path(conn, :index))
      body = assert response(conn, 200)
      for {_k, v} <- @valid_product_attrs do
        assert body =~ to_string(v)
      end
    end
  end
end
