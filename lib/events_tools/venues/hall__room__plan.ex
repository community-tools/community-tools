defmodule CommunityTools.Venues.Hall_Room_Plan do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Venues.Hall_Room_Plan


  schema "hall_room_plans" do
    field :name, :string
    belongs_to :hall, CommunityTools.Venues.Hall  # this was added

    timestamps()
  end

  @doc false
  def changeset(%Hall_Room_Plan{} = hall__room__plan, attrs) do
    hall__room__plan
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
