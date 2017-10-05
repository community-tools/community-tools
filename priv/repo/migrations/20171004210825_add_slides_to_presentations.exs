defmodule ConferenceTools.Repo.Migrations.AddSlidesToPresentations do
  use Ecto.Migration

  def change do
    alter table(:presentations) do
      add :slides_file, :string
      add :slides_link, :string
      add :slides_embed, :text
    end
  end
end
