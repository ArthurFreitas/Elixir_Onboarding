defmodule ImsWeb.PageController do
  use ImsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def sentry_check(_conn, _params) do
    raise "Hello from web service"
  end
end
