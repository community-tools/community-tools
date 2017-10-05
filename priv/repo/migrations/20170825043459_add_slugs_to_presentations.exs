defmodule CommunityTools.Repo.Migrations.AddSlugsToPresentations do
  use Ecto.Migration

  def change do
    alter table(:presentations) do
      add :slug, :string
    end

    create index(:presentations, [:slug], unique: true)

  end
end
