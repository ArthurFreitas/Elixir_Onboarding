defmodule ImsWeb.ReportControllerTest do
  use ExUnit.Case, async: false
  use ImsWeb.ConnCase
  import Mock

  @params_sent %{
    "email" => "teste@gmail.com",
    "type" => "product"
  }

  setup_with_mocks([{Ims.HttpClient.ReportService, [], [create: fn(_params) -> :ok end]}], context) do
    context
  end

  describe "request product report" do
    test "redirects to index and flashes that it will be available soon", %{conn: conn} do

      conn = post(conn, Routes.report_path(conn, :create), type: "product")

      assert get_flash(conn, :info) =~ "The report will be sent shortly"
    end

    test "sends a generate product report request to the service", %{conn: conn} do

      post(conn, Routes.report_path(conn, :create), @params_sent)

      assert_called(Ims.HttpClient.ReportService.create(@params_sent))
    end
  end
end
