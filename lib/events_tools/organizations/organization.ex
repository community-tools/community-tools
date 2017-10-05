defmodule CommunityTools.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Organizations.Organization
  alias CommunityTools.Sponsors.Sponsor

  schema "organizations" do
    field :email, :string
    field :facebook, :string
    field :github, :string
    field :linkedin, :string
    field :logo, :string
    field :name, :string
    field :phone, :string
    field :summary, :string
    field :twitter, :string
    field :type, :string
    field :website, :string
    has_many :sponsor, CommunityTools.Sponsors.Sponsor

    timestamps()
  end

  @doc false
  def changeset(%Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:name, :summary, :type, :website, :twitter, :logo, :linkedin, :github, :facebook, :email, :phone])
    |> validate_required([:name])
  end
end
