defmodule NikoSafeWeb.Router do
  use NikoSafeWeb, :router

  pipeline :browser do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NikoSafeWeb.Layouts, :root}
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NikoSafeWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", NikoSafeWeb do
    pipe_through :api

    post "/", UserController, :create
    post "/location", LocationController, :create
    post "/ussdtest", UssdController, :create

    post "/voice", VoiceController, :create

    post "/trigger", TriggerController, :create
  end

  # using graphql
  scope "/gapi" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: NikoSafeWeb.Schema

    forward "/graphql", Absinthe.Plug.GraphiQL, schema: NikoSafeWeb.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", NikoSafeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:niko_safe, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NikoSafeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
