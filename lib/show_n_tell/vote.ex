defmodule ShowNTell.Vote do
  @moduledoc """
  Vote model documentation
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ShowNTell.Repo

  @primary_key false

  schema "votes" do

    field :value, :integer

    belongs_to :user, ShowNTell.Vote
    belongs_to :talk, ShowNTell.Vote

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:value, :user_id, :talk_id])
    |> unique_constraint(:user, name: :votes_talk_user_id_index)
    |> validate_required([:value, :user_id, :talk_id])
  end

  def list_votes() do
    Repo.all(ShowNTell.Vote)
  end
end
