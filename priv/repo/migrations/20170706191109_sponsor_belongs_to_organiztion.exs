defmodule CommunityTools.Repo.Migrations.SponsorBelongsToCompany do
  use Ecto.Migration

  def change do
    alter table(:sponsors) do
      add :organization_id, references(:organizations)
    end

  end
end
