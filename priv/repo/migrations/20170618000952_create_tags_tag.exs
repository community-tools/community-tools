defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Tags.Tag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string

      timestamps()
    end

  end
end
