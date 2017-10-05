defmodule CommunityTools.Repo.Migrations.HallBelongsToBuilding do
  use Ecto.Migration

  def change do
    alter table(:halls) do
      add :building_id, references(:buildings)
    end

  end
end
