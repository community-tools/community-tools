defmodule CommunityTools.Repo.Migrations.CreateCommunityTools.Sponsors.Sponsorship do
  use Ecto.Migration

  def change do
    create table(:sponsorship_options) do
      add :name, :string
      add :summary, :text
      add :type, :string
      add :expo, :text
      add :camps, :text
      add :website, :text
      add :program, :text
      add :signage, :text
      add :social, :text
      add :swag, :text
      add :recruiting, :text
      add :price, :float
      add :stock, :integer

      timestamps()
    end

  end
end
