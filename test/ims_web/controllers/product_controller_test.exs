defmodule ImsWeb.ProductControllerTest do
  use ImsWeb.ConnCase
  use Ims.DataCase

  @moduletag :integration

  test "GET /product/index", %{conn: conn} do
    conn = get(conn, Routes.product_path(conn, :index))
    assert html_response(conn, 200) =~ "Stock"
  end
end
