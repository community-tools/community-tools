defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Venues.Room do
  use Ecto.Migration

  def change do
    create table(:venues_rooms) do
      add :name, :string

      timestamps()
    end

  end
end
