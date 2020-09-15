defmodule ImsWeb.ProductController do
  use ImsWeb, :controller

  def index(conn, _params) do
    render(conn, :list, products: [%{SKU: "sku", name: "nome", description: "description", quantity: 15, price: 150.9 }])
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id)
  end

  def new(conn, _params) do
  end

  def edit(conn, _params) do
  end

  def create(conn, _params) do
  end

  def update(conn, _params) do
  end

  def destroy(conn, _params) do
  end
end
