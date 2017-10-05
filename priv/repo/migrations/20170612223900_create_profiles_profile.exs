defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Accounts.Profile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string
      add :bio, :text
      add :avatar, :string
      add :organization, :string
      add :role, :string
      add :country, :string
      add :state, :string
      add :facebook, :string
      add :github, :string
      add :linkedin, :string
      add :twitter, :string
      add :website, :string

      timestamps()
    end

  end
end
