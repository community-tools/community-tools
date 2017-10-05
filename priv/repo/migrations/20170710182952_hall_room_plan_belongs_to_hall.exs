defmodule CommunityTools.Repo.Migrations.HallRoomPlanBelongsToHall do
  use Ecto.Migration

  def change do
    alter table(:hall_room_plans) do
      add :hall_id, references(:halls)
    end

  end
end
