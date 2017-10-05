defmodule CommunityTools.Repo.Migrations.CreatePresentationsEvents do
  use Ecto.Migration

  def change do

    create table(:presentations_events, primary_key: true) do
      add :presentation_id, references(:presentations)
      add :event_id, references(:events)

    timestamps()
    end
  end
end
