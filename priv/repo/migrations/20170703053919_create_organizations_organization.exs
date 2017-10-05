defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Organizations.Organization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :summary, :text
      add :type, :string
      add :website, :string
      add :twitter, :string
      add :linkedin, :string
      add :github, :string
      add :facebook, :string
      add :email, :string
      add :phone, :string

      timestamps()
    end

  end
end
