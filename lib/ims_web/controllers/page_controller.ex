defmodule ImsWeb.PageController do
  use ImsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
