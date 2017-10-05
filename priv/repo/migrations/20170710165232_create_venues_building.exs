defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Venues.Building do
  use Ecto.Migration

  def change do
    create table(:buildings) do
      add :name, :string

      timestamps()
    end

  end
end
