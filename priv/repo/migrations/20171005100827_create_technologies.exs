defmodule CommunityTools.Repo.Migrations.CreateTechnologies do
  use Ecto.Migration

  def change do
    create table(:technologies) do
      add :name, :string
      add :description, :text
      add :logo, :string

      timestamps()
    end

  end
end
