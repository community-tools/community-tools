defmodule CommunityTools.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :description, :text
      add :slug, :string

      timestamps()
    end

    create index(:roles, [:name], unique: true)
    create index(:roles, [:slug], unique: true)

  end
end
