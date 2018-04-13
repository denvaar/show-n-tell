defmodule ShowNTell.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes, primary_key: false ) do
      add :value, :integer
      add :talk_id, references(:talks, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:votes, [:user_id, :talk_id], name: :votes_talk_user_id_index)

    create index(:votes, [:talk_id])
    create index(:votes, [:user_id])
  end
end
