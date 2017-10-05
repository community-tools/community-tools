defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Comments.Comment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :title, :string
      add :body, :text
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end
