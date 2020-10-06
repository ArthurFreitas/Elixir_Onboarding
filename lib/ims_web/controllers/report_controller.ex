defmodule ImsWeb.ReportController do
  use ImsWeb, :controller
  alias Ims.HttpClient.ReportService

  def new(conn, _params) do
    render(conn, :new)
  end
  def create(conn, params) do
      params
      |> Map.drop(["_csrf_token"])
      |> ReportService.create

      conn
      |> put_flash(:info, "The report will be sent shortly")
      |> redirect(to: Routes.product_path(conn, :index))
  end
end
