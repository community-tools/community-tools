defmodule CommunityTools.Venues.Building do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Venues.Building


  schema "buildings" do
    field :name, :string
    belongs_to :venue, CommunityTools.Venues.Venue  # this was added
    has_many :halls, CommunityTools.Venues.Hall  # this was added

    timestamps()
  end

  @doc false
  def changeset(%Building{} = building, attrs) do
    building
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
