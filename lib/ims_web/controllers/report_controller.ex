defmodule ImsWeb.ReportController do
  use ImsWeb, :controller

  def create(conn, %{"type" => type}) do
    case type do
      "product" ->
        conn
        |> put_flash(:info, "The report will be available shortly.")
        |> redirect(to: Routes.product_path(conn, :index))
    end
  end
end
