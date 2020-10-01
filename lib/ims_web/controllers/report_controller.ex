defmodule ImsWeb.ReportController do
  use ImsWeb, :controller
  alias Ims.HttpClient.ReportService

  def create(conn, params) do
      params
      |> ReportService.create

      conn
      |> put_flash(:info, "The report will be available shortly.")
      |> redirect(to: Routes.product_path(conn, :index))
  end
end
