defmodule ImsWeb.ProductControllerTest do
  use ImsWeb.ConnCase
  use Ims.DataCase

  @moduletag :integration

  describe "index" do
    test "list all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))

      assert html_response(conn, 200) =~ "Stock"
    end
  end
end
