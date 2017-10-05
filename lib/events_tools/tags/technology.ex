defmodule CommunityTools.Tags.Technology do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Tags.Technology


  schema "technologies" do
    field :description, :string
    field :logo, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Technology{} = technology, attrs) do
    technology
    |> cast(attrs, [:name, :description, :logo])
    |> validate_required([:name])
  end
end
