defmodule CommunityTools.Accounts.Roles do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Accounts.Roles
  alias CommunityTools.SlugsRoles

  @derive {Phoenix.Param, key: :slug}
  schema "roles" do
    field :description, :string
    field :name, :string
    field :slug, SlugsRoles.Type
    many_to_many :users, CommunityTools.Accounts.User, join_through: "users_roles", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Roles{} = roles, attrs) do
    roles
    |> cast(attrs, [:name, :description, :slug])
    |> validate_required([:name])
    |> SlugsRoles.maybe_generate_slug
    |> SlugsRoles.unique_constraint

  end
end
