defmodule CommunityTools.Events.Event do
  use Ecto.Schema
  use Arc.Ecto.Schema
  #import Ecto.Query
  import Ecto.Changeset

  #alias CommunityTools.Events.Event
  #alias CommunityTools.Accounts.User
  alias CommunityTools.Repo
  alias CommunityTools.SlugsEvents

  @derive {Phoenix.Param, key: :slug}
  schema "events" do
    field :background, :string
    field :color, :string
    field :color_accent, :string
    field :color_primary, :string
    field :color_secondary, :string
    field :date, Ecto.DateTime
    field :description, :string
    field :email, :string
    field :github, :string
    field :facebook, :string
    field :icon, CommunityTools.Icon.Type
    field :name, :string
    field :intro_location, :string
    field :intro_news, :string
    field :intro_schedule, :string
    field :intro_speakers, :string
    field :intro_sponsors, :string
    field :intro_team, :string
    field :intro_venue, :string
    field :slug, SlugsEvents.Type
    field :tag, :string
    field :tagline, :string
    field :teaser, :string
    field :twitter, :string
    field :website, :string
    many_to_many :organizers, CommunityTools.Accounts.Profile, join_through: "events_organizers", on_delete: :delete_all, on_replace: :delete
    many_to_many :presentations, CommunityTools.Presentations.Presentation, join_through: "presentations_events", on_delete: :delete_all, on_replace: :delete
    many_to_many :posts, CommunityTools.Posts.Post, join_through: "posts_events", on_delete: :delete_all, on_replace: :delete
    timestamps()
  end


  @required_file_fields ~w()
  @optional_file_fields ~w(icon)


  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:background, :color, :color_accent, :color_primary, :color_secondary, :date, :description, :email, :github, :facebook, :icon, :intro_location, :intro_news, :intro_schedule, :intro_speakers, :intro_team, :intro_sponsors, :intro_venue, :name, :slug, :tag, :tagline, :teaser, :twitter, :website ])
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
    |> validate_required([:name])
    #|> SlugsEvents.maybe_generate_slug
    #|> SlugsEvents.unique_constraint

    #|> Ecto.Changeset.cast_assoc(:tags)
    #|> validate_required(@required_fields)

  end

end
