defmodule ImsWeb.Router do
  use ImsWeb, :router
  use Plug.ErrorHandler

  @elastic_search_helper Application.get_env(:ims, :elastic_search_helper)

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: stack} = err) do
    err = %{err | stack: Exception.format_stacktrace(stack)}
    @elastic_search_helper.post(:error, :uncaught, conn, err)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ImsWeb do
    pipe_through :browser
    get "/", ProductController, :index
  end

  scope "/product", ImsWeb do
    pipe_through :browser
    get "/", ProductController, :index
    post "/", ProductController, :create
    get "/new", ProductController, :new
    get "/missing", ProductController, :missing
    get "/users/:id/edit", ProductController, :edit
    get "/:id", ProductController, :show
    put "/:id", ProductController, :update
    patch "/:id", ProductController, :update
    post "/:id", ProductController, :update
    delete "/:id", ProductController, :destroy
  end

  scope "/report", ImsWeb do
    pipe_through :browser
    post "/new", ReportController, :create
    post "/", ReportController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ImsWeb.Telemetry
    end
  end
end
