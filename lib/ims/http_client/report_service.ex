defmodule Ims.HttpClient.ReportService do
  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.get_env(:ims, :report_service_api_url)
  plug Tesla.Middleware.JSON

  def create(params) do
    post("/create", params)
  end
end
