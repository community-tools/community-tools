defmodule CommunityToolsWeb.RolesController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Accounts
  alias CommunityTools.Accounts.Roles
  alias CommunityTools.Repo

  def index(conn, _params, current_user, claims) do
    roles = Accounts.list_roles()
    render(conn, "index.html", roles: roles, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Accounts.change_roles(%Roles{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"roles" => roles_params}, current_user, claims) do
    case Accounts.create_roles(roles_params) do
      {:ok, roles} ->
        conn
        |> put_flash(:info, "Roles created successfully.")
        |> redirect(to: roles_path(conn, :show, roles))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    roles = Repo.get_by!(Roles, slug: id)
    #roles = Accounts.get_roles!(id)
    render(conn, "show.html", roles: roles, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    roles = Accounts.get_roles!(id)
    changeset = Accounts.change_roles(roles)
    render(conn, "edit.html", roles: roles, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "roles" => roles_params}, current_user, claims) do
    roles = Accounts.get_roles!(id)

    case Accounts.update_roles(roles, roles_params) do
      {:ok, roles} ->
        conn
        |> put_flash(:info, "Roles updated successfully.")
        |> redirect(to: roles_path(conn, :show, roles))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", roles: roles, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    roles = Accounts.get_roles!(id)
    {:ok, _roles} = Accounts.delete_roles(roles)

    conn
    |> put_flash(:info, "Roles deleted successfully.")
    |> redirect(to: roles_path(conn, :index))
  end
end
