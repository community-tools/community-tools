defmodule CommunityTools.Sponsors.SponsorshipOption do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Sponsors.SponsorshipOption
  alias CommunityTools.Sponsors.Sponsor

  schema "sponsorship_options" do
    field :camps, :string
    field :expo, :string
    field :name, :string
    field :price, :decimal
    field :program, :string
    field :recruiting, :string
    field :signage, :string
    field :social, :string
    field :stock, :integer
    field :summary, :string
    field :swag, :string
    field :type, :string
    field :website, :string
    has_many :sponsor, CommunityTools.Sponsors.Sponsor

    timestamps()
  end

  @doc false
  def changeset(%SponsorshipOption{} = sponsorship_option, attrs) do
    sponsorship_option
    |> cast(attrs, [:name, :summary, :type, :expo, :camps, :website, :program, :signage, :social, :swag, :recruiting, :price, :stock])
    |> validate_required([:name])
  end
end
