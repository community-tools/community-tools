defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Status.Status do
  use Ecto.Migration

  def change do
    create table(:status) do
      add :title, :string
      add :summary, :text

      timestamps()
    end

  end
end
