defmodule JackMarchantWeb.Router do
  use JackMarchantWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", JackMarchantWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/articles/:slug", PageController, :post)
    post("/subscribe", SubscribeController, :subscribe)

    get("/:page", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", JackMarchantWeb do
  #   pipe_through :api
  # end
end
