defmodule ShowNTell.Talk do
  @moduledoc """
  Talk model documentation
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ShowNTell.Repo
  alias ShowNTell.Talk

  schema "talks" do
    field :talk_date, :date
    field :description, :string
    field :estimated_duration, :integer
    field :title, :string

    belongs_to :speaker, ShowNTell.User
    has_many :votes, ShowNTell.Vote

    timestamps()
  end

  @doc false
  def changeset(talk, attrs) do
    talk
    |> cast(attrs, [:title, :description, :estimated_duration, :talk_date])
    |> validate_required([:title, :description, :estimated_duration, :talk_date])
  end

  def list_talks() do
    Repo.all(Talk)
  end

  def create_talk(args) do
    %Talk{}
    |> changeset(args)
    |> Repo.insert
  end
end
