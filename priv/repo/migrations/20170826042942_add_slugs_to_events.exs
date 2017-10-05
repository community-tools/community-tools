defmodule CommunityTools.Repo.Migrations.AddSlugsToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :slug, :string
    end

    create index(:events, [:slug], unique: true)
  end
end
