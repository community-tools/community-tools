defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Venues.Hall do
  use Ecto.Migration

  def change do
    create table(:halls) do
      add :name, :string

      timestamps()
    end

  end
end
