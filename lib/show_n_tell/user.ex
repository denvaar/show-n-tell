defmodule ShowNTell.User do
  @moduledoc """
  User model documentation
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :github_token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :github_token])
    |> validate_required([:first_name, :last_name, :email, :github_token])
  end
end
