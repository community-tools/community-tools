defmodule CommunityTools.Repo.Migrations.AddProfileNameFields do
  use Ecto.Migration

  def change do

    alter table(:profiles) do
      add :name_first, :string, size: 255
      add :name_last, :string, size: 255
    end
  end
end
