defmodule ShowNTell.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :date, :date
    field :description, :string
    field :estimated_duration, :integer
    field :title, :string

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
