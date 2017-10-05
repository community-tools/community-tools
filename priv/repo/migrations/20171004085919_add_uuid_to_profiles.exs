defmodule ConferenceTools.Repo.Migrations.AddUuidToProfiles do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :uuid, :string
    end
  end

end
