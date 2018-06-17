defmodule ShowNTell.Repo.Migrations.AddSpeakerIdToTalks do
  use Ecto.Migration

  def change do
    alter table(:talks) do
      add :speaker_id, references(:users)
    end
  end
end
