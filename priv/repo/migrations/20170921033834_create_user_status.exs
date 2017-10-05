defmodule ConferenceTools.Repo.Migrations.CreateUserStatus do
  use Ecto.Migration

  def change do

    create table(:users_status, primary_key: true) do
      add :user_id, references(:users)
      add :status_id, references(:status)

     timestamps()
    end

  end
end
