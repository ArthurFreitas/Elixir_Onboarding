defmodule ImsWeb.ProductControllerTest do
  use ExUnit.Case, async: false
  use Ims.DataCase, async: false
  use ImsWeb.ConnCase
  alias Ims.Product

  @moduletag :integration

  @valid_product_attrs %{
    SKU: "AbC-12",
    name: "Abacate",
    price: 15.0,
    barcode: "12345678"
  }

  @invalid_product_attrs %{
    SKU: "1@~;",
    barcode: "1234567a",
    price: -1
  }

  @non_existing_product_id "5f6207f37200b53f472927ce"

  describe "index" do
    test "redirects to stock page", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))

      assert html_response(conn, 200) =~ "Stock"
    end
  end

  describe "create product" do

    test "redirects to index and lists new product", %{conn: conn} do
      {conn, product} = create_valid_product(conn)

      assert redirected_to(conn) == "/product"
      assert product.'SKU' =~ @valid_product_attrs.'SKU'

      conn = get(conn, Routes.product_path(conn, :index))
      body = assert response(conn, 200)
      assert_product_attrs_in_body(body, @valid_product_attrs)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_product_attrs)
      assert response(conn, 200) =~ "error"
    end

  end

  describe "delete product" do
    test "deletes existing product", %{conn: conn} do
      {conn, product} = create_valid_product(conn)

      conn = delete(conn, Routes.product_path(conn, :destroy, product))
      assert redirected_to(conn) == "/product"

      conn = get(conn, Routes.product_path(conn, :show, product.id))
      assert response(conn, 404)
    end

    test "show missing page if the product doesnt exist", %{conn: conn} do
      conn = delete(conn, Routes.product_path(conn, :destroy, @non_existing_product_id))
      body = assert response(conn, 404)
      assert body =~ "This product does not exist"
    end
  end

  describe "show product" do

    test "shows product info", %{conn: conn} do
      {conn, %Product{id: id}} = create_valid_product(conn)

      conn = get(conn, Routes.product_path(conn, :show, id))
      body = assert response(conn, 200)
      assert_product_attrs_in_body(body, @valid_product_attrs)
    end

    test "shows missing product info if it doesn't exist", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :show, @non_existing_product_id))
      body = assert response(conn, 404)
      assert body =~ "This product does not exist"
    end

  end

  describe "update product" do
    test "updates product with valid info", %{conn: conn} do
      updated_product = %{@valid_product_attrs | SKU: "updated-sku"}

      {conn, %Product{id: id}} = create_valid_product(conn)

      conn = post(conn, Routes.product_path(conn, :update, id), product: updated_product)
      assert redirected_to(conn) == "/product"

      conn = get(conn, Routes.product_path(conn, :show, id))
      body = assert response(conn, 200)
      assert_product_attrs_in_body(body, updated_product)
    end

    test "shows missing product info if it doesn't exist", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :update, @non_existing_product_id), product: @valid_product_attrs)
      assert response(conn, 404)
    end

    test "renders errors when updated data is invalid", %{conn: conn} do
      {conn, %Product{id: id}} = create_valid_product(conn)

      conn = post(conn, Routes.product_path(conn, :update, id), product: @invalid_product_attrs)
      assert response(conn, 200) =~ "error"
    end
  end

  defp create_valid_product(conn) do
    conn = post(conn, Routes.product_path(conn, :create), product: @valid_product_attrs)
    product = Ims.ProductHelper.list()
    |> Enum.filter(fn (p) -> p.'SKU' == @valid_product_attrs.'SKU' end)
    |> hd

    {conn, product}
  end

  defp assert_product_attrs_in_body(body, attrs) do
    for {_k, v} <- attrs do
      assert body =~ to_string(v)
    end
  end
end
