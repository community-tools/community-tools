defmodule CommunityTools.Venues.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Venues.Room


  schema "rooms" do
    field :name, :string
    belongs_to :hall, CommunityTools.Venues.Hall  # this was added
    belongs_to :hall_room_plan, CommunityTools.Venues.Hall_Room_Plan  # this was added

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
