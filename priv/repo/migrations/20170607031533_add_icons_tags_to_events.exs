defmodule CommunityTools.Repo.Migrations.AddIconsTagsToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :icon, :string, size: 255
      add :tag, :string, size: 255
    end
  end
end
