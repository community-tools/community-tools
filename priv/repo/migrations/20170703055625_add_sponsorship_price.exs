defmodule CommunityTools.Repo.Migrations.AddSponsorshipPrice do
  use Ecto.Migration

  def change do

    alter table(:sponsorship_options) do
      add :price, :decimal
    end

  end
end
