defmodule CommunityToolsWeb.HallController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Venues

  def index(conn, _params, current_user, claims) do
    halls = Venues.list_halls()
    render(conn, "index.html", halls: halls, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Venues.change_hall(%CommunityTools.Venues.Hall{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"hall" => hall_params}, current_user, claims) do
    case Venues.create_hall(hall_params) do
      {:ok, hall} ->
        conn
        |> put_flash(:info, "Hall created successfully.")
        |> redirect(to: hall_path(conn, :show, hall))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    hall = Venues.get_hall!(id)
    render(conn, "show.html", hall: hall, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    hall = Venues.get_hall!(id)
    changeset = Venues.change_hall(hall)
    render(conn, "edit.html", hall: hall, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "hall" => hall_params}, current_user, claims) do
    hall = Venues.get_hall!(id)

    case Venues.update_hall(hall, hall_params) do
      {:ok, hall} ->
        conn
        |> put_flash(:info, "Hall updated successfully.")
        |> redirect(to: hall_path(conn, :show, hall))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hall: hall, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    hall = Venues.get_hall!(id)
    {:ok, _hall} = Venues.delete_hall(hall)

    conn
    |> put_flash(:info, "Hall deleted successfully.")
    |> redirect(to: hall_path(conn, :index))
  end
end
