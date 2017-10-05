defmodule CommunityTools.Repo.Migrations.CreateEventsOrganizers do
  use Ecto.Migration

  def change do

    create table(:events_organizers, primary_key: true) do
      add :event_id, references(:events)
      add :profile_id, references(:profiles)

    timestamps()
    end
  end
end
