defmodule ImsWeb.ReportControllerTest do
  use ExUnit.Case, async: false
  use ImsWeb.ConnCase
  alias Ims.DTO.Message
  import Mock

  setup_with_mocks([{Ims.QueueHelper, [], [enqueue: fn(_msg, _queue) -> :ok end]}], context) do
    context
  end

  describe "request product report" do
    test "redirects to index and flashes that it will be available soon", %{conn: conn} do

      conn = post(conn, Routes.report_path(conn, :create), type: "product")

      assert get_flash(conn, :info) =~ "The report will be available shortly"
    end

    test "enqueues a generate product report request", %{conn: conn} do

      post(conn, Routes.report_path(conn, :create), type: "product")

      assert_called(Ims.QueueHelper.enqueue(%Message{action: :create, type: :product}, :report))
    end
  end
end
