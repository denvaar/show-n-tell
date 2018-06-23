defmodule ShowNTellWeb.TalksResolver do
  @moduledoc """
  This module is used from Absinthen GraphQL schema
  to resolve DB queries and mutations.
  """

  alias ShowNTell.Repo
  alias ShowNTell.Talk

  def talk(_root, args, _info) do
    {:ok, Repo.get(Talk, args[:id])}
  end

  def talks(_root, _args, _info) do
    talks = Talk.list_talks()

    {:ok, talks}
  end

  def create_talk(_root, args, _info) do
    case Talk.create_talk(args) do
      {:ok, talk} -> {:ok, talk}
      _error -> {:error, "could not create talk"}
    end
  end
end
