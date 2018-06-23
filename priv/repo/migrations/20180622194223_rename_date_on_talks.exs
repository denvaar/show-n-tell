defmodule ShowNTell.Repo.Migrations.RenameDateOnTalks do
  use Ecto.Migration

  def change do
    rename table(:talks), :date, to: :talk_date
  end
end
