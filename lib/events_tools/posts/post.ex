defmodule CommunityTools.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Posts.Post
  alias CommunityTools.Slugs

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :body, :string
    field :date, :date
    field :subtitle, :string
    field :teaser, :string
    field :title, :string
    field :slug, Slugs.Type
    has_many :comments, CommunityTools.Comments.Comment
    many_to_many :events, CommunityTools.Events.Event, join_through: "posts_events", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :date, :slug, :subtitle, :teaser])
    |> validate_required([:title, :body, :date])
    |> Slugs.maybe_generate_slug
    |> Slugs.unique_constraint
  end

end
