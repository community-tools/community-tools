defmodule CommunityTools.Repo.Migrations.AddEventsTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, size: 255
      add :description, :string, size: 5000
      add :date, :utc_datetime

      timestamps()
    end

  end
end
