defmodule ConferenceTools.Repo.Migrations.CreatePresentationOwners do
  use Ecto.Migration

  def change do

    create table(:presentations_owners, primary_key: true) do
      add :presentation_id, references(:presentations)
      add :user_id, references(:users)

     timestamps()
    end

  end
end
