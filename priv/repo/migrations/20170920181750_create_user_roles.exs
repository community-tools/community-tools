defmodule CommunityTools.Repo.Migrations.CreateUserRoles do
  use Ecto.Migration

  def change do

    create table(:users_roles, primary_key: true) do
      add :user_id, references(:users)
      add :role_id, references(:roles)

    timestamps()
    end

  end
end
