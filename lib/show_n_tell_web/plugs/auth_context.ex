defmodule ShowNTellWeb.AuthContext do
  @moduledoc """
  Takes the token from the request header
  and attempts to load the associated user
  from the database into the graphql context.
  """

  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias ShowNTell.{Repo, User}

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    User
    |> where(github_token: ^token)
    |> Repo.one()
    |> resolve_user()
  end

  defp resolve_user(nil), do: {:error, "Invalid authorization token"}
  defp resolve_user(user), do: {:ok, user}
end
