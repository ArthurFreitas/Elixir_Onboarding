defmodule ImsWeb.ReportControllerTest do
  use ExUnit.Case, async: false
  use ImsWeb.ConnCase
  alias Ims.Product
  alias Ims.DTO.Message

  describe "request product report" do
    test "redirects to index and flashes that it will be available soon", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), type: "product")
      assert get_flash(conn, :info) =~ "The report will be available shortly"
    end

    test "enqueues a generate product report request", %{conn: conn} do
      :meck.new(Ims.QueueHelper)
      :meck.expect(
        Ims.QueueHelper,
        :enqueue,
        fn(_msg, _queue) -> :ok end
      )

      post(conn, Routes.report_path(conn, :create), type: "product")

      assert :meck.called(
        Ims.QueueHelper,
        :enqueue,
        [%Message{action: :create, type: :product}, :report]
      )

      :meck.unload(Ims.QueueHelper)
    end
  end
end
