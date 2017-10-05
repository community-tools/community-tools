defmodule CommunityTools.Repo.Migrations.AlterPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :subtitle, :string
      add :teaser, :text

    end

  end
end
