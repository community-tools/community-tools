defmodule CommunityTools.Repo.Migrations.CreatePresentationsPresenters do
  use Ecto.Migration

  def change do

    create table(:presentations_presenters, primary_key: true) do
        add :presentation_id, references(:presentations)
        add :profile_id, references(:profiles)

      timestamps()
    end
  end
end
