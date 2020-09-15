defmodule ImsWeb.ProductController do
  use ImsWeb, :controller
  @products_mock ([%{SKU: "sku", name: "nome", description: "description", quantity: 15, price: 150.9 }])

  def index(conn, _params) do
    render(conn, :list, products: @products_mock)
  end

  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id, product: hd(@products_mock))
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
