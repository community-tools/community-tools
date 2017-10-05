defmodule CommunityTools.Repo.Migrations.AdjustUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :slug, :string
    end

    create index(:users, [:slug], unique: true)
    create index(:users, [:email], unique: true)
  end
end
