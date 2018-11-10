defmodule ShowNTellWeb.Router do
  use ShowNTellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug ShowNTellWeb.AuthContext
  end

  scope "/api", ShowNTellWeb do
    pipe_through :api

    resources "/authenticate", AuthController, singleton: true, only: [:create, :show]
  end

  scope "/" do
    pipe_through [:api, :graphql]

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ShowNTellWeb.Schema
  end
end
