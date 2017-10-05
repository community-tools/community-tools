defmodule CommunityTools.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CommunityTools.Accounts.User
  alias CommunityTools.Repo


  schema "users" do
    field :email, :string
    field :password_web, :string, virtual: true
    field :password, :string
    has_one :profile, CommunityTools.Accounts.Profile
    many_to_many :presentations, CommunityTools.Presentations.Presentation, join_through: "presentations_owners", on_delete: :delete_all, on_replace: :delete
    many_to_many :roles, CommunityTools.Accounts.Roles, join_through: "users_roles", on_delete: :delete_all, on_replace: :delete
    many_to_many :status, CommunityTools.Status.Status, join_through: "users_status", on_delete: :delete_all, on_replace: :delete
    has_many :authorizations, CommunityTools.Accounts.Authorization

    timestamps()
  end


  @required_fields ~w(email)a
  @optional_fields ~w()a

  def registration_changeset(model, params \\ :empty) do
    model
    |>cast(params, ~w(email)a)
    |> validate_required(@required_fields)
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email])
  end
end
