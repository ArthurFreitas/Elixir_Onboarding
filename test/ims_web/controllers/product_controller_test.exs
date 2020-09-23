defmodule ImsWeb.ProductControllerTest do
  use ImsWeb.ConnCase

  test "GET /product/", %{conn: conn} do
    conn = get(conn, "/product/")
    assert html_response(conn, 200) =~ "Stock"
  end
end
