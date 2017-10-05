defmodule CommunityToolsWeb.UserController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Repo
  alias CommunityTools.Accounts

  def index(conn, _params, current_user, claims) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Accounts.change_user(%CommunityTools.Accounts.User{})
    user = %{roles: [], status: []}
    roles_all = Repo.all(CommunityTools.Accounts.Roles)
    status_all = Repo.all(CommunityTools.Status.Status)
    render(conn, "new.html", changeset: changeset, user: user, roles_all: roles_all, status_all: status_all, current_user: current_user, claims: claims)
  end

  def create(conn, %{"user" => user_params}, current_user, claims) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        roles_all = Repo.all(CommunityTools.Accounts.Roles)
        status_all = Repo.all(CommunityTools.Status.Status)
        render(conn, "new.html", changeset: changeset, roles_all: roles_all, status_all: status_all, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    user = Accounts.get_user!(id)
    |> Repo.preload(:profile)
    |> Repo.preload(:roles)
    |> Repo.preload(:status)
    render(conn, "show.html", user: user, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    user = Accounts.get_user!(id)
    |> Repo.preload(:roles)
    |> Repo.preload(:status)
    changeset = Accounts.change_user(user)
    roles_all = Repo.all(CommunityTools.Accounts.Roles)
    status_all = Repo.all(CommunityTools.Status.Status)
    render(conn, "edit.html", changeset: changeset, user: user, roles_all: roles_all, status_all: status_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user, claims) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        roles_all = Repo.all(CommunityTools.Accounts.Roles)
        status_all = Repo.all(CommunityTools.Status.Status)
        render(conn, "edit.html", user: user, changeset: changeset, roles_all: roles_all, status_all: status_all, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
