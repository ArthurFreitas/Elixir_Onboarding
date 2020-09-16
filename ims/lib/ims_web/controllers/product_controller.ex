defmodule ImsWeb.ProductController do
  use ImsWeb, :controller
  alias Ims.ProductHelper

  def index(conn, _params) do
    render(conn, :list, products: ProductHelper.list)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id, product: ProductHelper.get!(id))
  end

  def new(conn, _params) do
  end

  def edit(conn, %{"id" => id}) do
  end

  def create(conn, _params) do
  end

  def update(conn, %{"id" => id}) do
  end

  def destroy(conn, %{"id" => id}) do
  end
end
