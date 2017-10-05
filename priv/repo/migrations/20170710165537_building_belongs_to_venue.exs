defmodule CommunityTools.Repo.Migrations.BuildingBelongsToVenue do
  use Ecto.Migration

  def change do
    alter table(:buildings) do
      add :venue_id, references(:venues)
    end
  end
end
