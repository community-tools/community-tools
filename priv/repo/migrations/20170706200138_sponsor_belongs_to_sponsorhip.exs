defmodule CommunityTools.Repo.Migrations.SponsorBelongsToSponsorhip do
  use Ecto.Migration

  def change do
    alter table(:sponsors) do
      add :sponsorship_id, references(:sponsorship_options)
    end

  end
end
