defmodule ShowNTell.Repo.Migrations.AddPhotoToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :photo, :string
    end
  end
end
