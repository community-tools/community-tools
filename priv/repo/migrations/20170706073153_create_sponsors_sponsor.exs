defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Sponsors.Sponsor do
  use Ecto.Migration

  def change do
    create table(:sponsors) do
      add :name, :string

      timestamps()
    end

  end
end
