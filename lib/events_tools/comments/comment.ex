defmodule CommunityTools.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Comments.Comment


  schema "comments" do
    field :body, :string
    field :title, :string
    belongs_to :post, CommunityTools.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
