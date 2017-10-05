defmodule CommunityTools.Repo.Migrations.RoomBelongsToHall do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :hall_id, references(:halls)
      add :hall_room_plan_id, references(:hall_room_plans)

    end
  end
end
