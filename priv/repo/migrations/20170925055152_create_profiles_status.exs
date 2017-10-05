defmodule ConferenceTools.Repo.Migrations.CreateProfilesStatus do
  use Ecto.Migration

  def change do

    create table(:proiles_status, primary_key: true) do
      add :profile_id, references(:profiles)
      add :status_id, references(:status)

     timestamps()
    end

  end
end
