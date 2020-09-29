defmodule ImsWeb.ReportController do
  use ImsWeb, :controller
  alias Ims.QueueHelper
  alias Ims.DTO.Message

  def create(conn, %{"type" => type}) do
    case type do
      "product" ->
        %Message{action: :create, type: :product}
        |> QueueHelper.enqueue(ImsReport.Job.ReportJob)

        conn
        |> put_flash(:info, "The report will be available shortly.")
        |> redirect(to: Routes.product_path(conn, :index))
    end
  end
end
