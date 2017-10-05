defmodule CommunityTools.Sponsors.Sponsor do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Sponsors.Sponsor


  schema "sponsors" do
    field :name, :string
    belongs_to :organization, CommunityTools.Organizations.Organization, on_replace: :nilify
    belongs_to :sponsorship_option, CommunityTools.Sponsors.SponsorshipOption, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(%Sponsor{} = sponsor, attrs) do
    sponsor
    |> cast(attrs, [:name])
    #|> cast_assoc(:organization)
    #|> cast_assoc(:sponsorship_option)
    |> validate_required([:name])
  end
end
