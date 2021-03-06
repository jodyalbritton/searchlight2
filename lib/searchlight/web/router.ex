defmodule Searchlight.Web.Router do
  use Searchlight.Web, :router

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

  scope "/", Searchlight.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new]
    resources "/users", UserController
    resources "/services", ServiceController
    resources "/bots", BotController
    resources "/devices", DeviceController
    resources "/tests", TestController
    resources "/scenarios", ScenarioController
  end

  scope "/api/v1", Searchlight.Web do
    pipe_through :api
    resources "/events", EventController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Searchlight.Web do
  #   pipe_through :api
  # end
end
