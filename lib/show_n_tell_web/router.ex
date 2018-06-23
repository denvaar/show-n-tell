defmodule ShowNTellWeb.Router do
  use ShowNTellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShowNTellWeb do
    pipe_through :api

    post "/authenticate", AuthController, :create
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ShowNTellWeb.Schema
  end
end
