defmodule ImsWeb.ReportControllerTest do
  use ExUnit.Case, async: false
  use ImsWeb.ConnCase
  alias Ims.DTO.Message
  import Mock

  describe "request product report" do
    test_with_mock "redirects to index and flashes that it will be available soon", %{conn: conn},
      Ims.QueueHelper, [], [enqueue: fn(_msg, _queue) -> :ok end] do

      conn = post(conn, Routes.report_path(conn, :create), type: "product")

      assert get_flash(conn, :info) =~ "The report will be available shortly"
    end

    test_with_mock "enqueues a generate product report request", %{conn: conn},
      Ims.QueueHelper, [], [enqueue: fn(_msg, _queue) -> :ok end] do

      post(conn, Routes.report_path(conn, :create), type: "product")

      assert_called(Ims.QueueHelper.enqueue(%Message{action: :create, type: :product}, :report))
    end
  end
end
