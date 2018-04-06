defmodule ShowNTell.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :description, :string
      add :estimated_duration, :integer
      add :date, :date

      timestamps()
    end

  end
end
