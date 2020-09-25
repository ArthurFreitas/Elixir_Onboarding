defmodule ImsWeb.ReportControllerTest do
  use ExUnit.Case
  use ImsWeb.ConnCase
  alias Ims.Product

  describe "request product report" do
    test "redirects to index and flashes that it will be available soon", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), type: "product")
      assert get_flash(conn, :info) =~ "The report will be available shortly"
    end
  end
end
