defmodule CommunityTools.Accounts.Profile do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Accounts.Profile
  alias CommunityTools.SlugsProfiles

  @derive {Phoenix.Param, key: :slug}
  schema "profiles" do
    field :bio, :string
    field :country, :string
    field :facebook, :string
    field :github, :string
    field :linkedin, :string
    field :name_first, :string
    field :name_last, :string
    field :organization, :string
    field :role, :string
    field :state, :string
    field :slug, SlugsProfiles.Type
    field :twitter, :string
    field :website, :string
    belongs_to :user, CommunityTools.Accounts.User  # this was added
    many_to_many :events, CommunityTools.Events.Event, join_through: "events_organizers", on_delete: :delete_all, on_replace: :delete
    many_to_many :presentations, CommunityTools.Presentations.Presentation, join_through: "presentations_presenters", on_delete: :delete_all, on_replace: :delete
    many_to_many :status, CommunityTools.Status.Status, join_through: "profiles_status", on_delete: :delete_all, on_replace: :delete
    field :uuid, :string
    field :avatar, CommunityTools.Avatar.Type


    timestamps()
  end

  @required_fields ~w()
  @optional_fields ~w()

  @required_file_fields ~w()
  @optional_file_fields ~w(avatar)

  @doc false
  def changeset(%Profile{} = profile, attrs) do
    profile
    |> cast(attrs, [:bio, :avatar, :organization, :role, :country, :state, :facebook, :github, :linkedin, :name_first, :name_last, :slug, :twitter, :user_id, :website, :uuid])
    |> validate_required([:name_first])
    |> SlugsProfiles.maybe_generate_slug
    |> SlugsProfiles.unique_constraint
  end

  def avatar_changeset(profile, attrs) do
    profile
    |> cast_attachments(attrs, @required_file_fields, @optional_file_fields)
  end


  defp check_uuid(changeset) do
    if get_field(changeset, :uuid) == nil do
      force_change(changeset, :uuid, UUID.uuid1)
    else
      changeset
    end
  end

end
