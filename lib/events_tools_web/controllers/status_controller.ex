defmodule CommunityToolsWeb.StatusController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Status

  def index(conn, _params, current_user, claims) do
    status = Status.list_status()
    render(conn, "index.html", status: status, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Status.change_status(%CommunityTools.Status.Status{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"status" => status_params}, current_user, claims) do
    case Status.create_status(status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status created successfully.")
        |> redirect(to: status_path(conn, :show, status))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    status = Status.get_status!(id)
    render(conn, "show.html", status: status, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    status = Status.get_status!(id)
    changeset = Status.change_status(status)
    render(conn, "edit.html", status: status, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "status" => status_params}, current_user, claims) do
    status = Status.get_status!(id)

    case Status.update_status(status, status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status updated successfully.")
        |> redirect(to: status_path(conn, :show, status))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", status: status, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    status = Status.get_status!(id)
    {:ok, _status} = Status.delete_status(status)

    conn
    |> put_flash(:info, "Status deleted successfully.")
    |> redirect(to: status_path(conn, :index))
  end
end
