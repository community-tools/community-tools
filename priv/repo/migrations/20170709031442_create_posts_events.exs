defmodule CommunityTools.Repo.Migrations.CreatePostsEvents do
  use Ecto.Migration

  def change do

    create table(:posts_events, primary_key: true) do
      add :post_id, references(:posts)
      add :event_id, references(:events)

    timestamps()
    end
  end
end
