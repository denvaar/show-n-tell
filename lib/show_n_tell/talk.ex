defmodule ShowNTell.Talk do
  @moduledoc """
  Talk model documentation
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :date, :date
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
    |> cast(attrs, [:title, :description, :estimated_duration, :date])
    |> validate_required([:title, :description, :estimated_duration, :date])
  end
end
