defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Venues.Venue do
  use Ecto.Migration

  def change do
    create table(:venues_venues) do
      add :name, :string

      timestamps()
    end

  end
end
