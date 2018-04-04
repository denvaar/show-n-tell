defmodule ShowNTellWeb.Router do
  use ShowNTellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShowNTellWeb do
    pipe_through :api
  end
end
