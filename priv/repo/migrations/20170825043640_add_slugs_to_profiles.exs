defmodule CommunityTools.Repo.Migrations.AddSlugsToProfiles do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :slug, :string
    end

    create index(:profiles, [:slug], unique: true)
  end
end
