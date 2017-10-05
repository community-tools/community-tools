defmodule CommunityTools.Repo.Migrations.AddFieldsToEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :camp, :string, size: 255
      add :color, :string, size: 6
      add :email, :string, size: 255
      add :facebook, :string, size: 255
      add :github, :string, size: 255
      add :twitter, :string, size: 255
      add :website, :string, size: 255
    end
  end
end
