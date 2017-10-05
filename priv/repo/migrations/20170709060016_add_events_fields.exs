defmodule CommunityTools.Repo.Migrations.AddEventsFields do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :background, :text
      add :color_accent, :string
      add :color_primary, :string
      add :color_secondary, :string
      add :location, :text
      add :news, :text
      add :schedule, :text
      add :speakers, :text
      add :sponsors, :text
      add :tagline, :text
      add :teaser, :text
      add :team, :text
      add :venue, :text
    end
  end
end
