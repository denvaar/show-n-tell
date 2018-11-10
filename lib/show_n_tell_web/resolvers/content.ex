defmodule ShowNTellWeb.Resolvers.Content do
  @moduledoc """
  Used from the GraphQL schema to resolve
  database queries and mutations.
  """

  alias ShowNTell.Repo
  alias ShowNTell.{Talk, User}

  def users(_root, _args, _info) do
    {:ok, User.list_users()}
  end

  def get_user(_root, %{id: id}, _info) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      _error -> {:error, "User does not exist"}
    end
  end

  def talks(_root, _args, _info) do
    {:ok, Talk.list_talks()}
  end

  def get_talk(_root, %{id: id}, _info) do
    case Repo.get(Talk, id) do
      %Talk{} = talk -> {:ok, talk}
      _error -> {:error, "Talk does not exist"}
    end
  end

  def create_talk(_root, args, %{context: %{current_user: _user}}) do
    case Talk.create_talk(args) do
      {:ok, talk} -> {:ok, talk}
      _error -> {:error, "Could not create talk"}
    end
  end

  def create_talk(_root, _args, _info), do: {:error, "Access denied"}
end
