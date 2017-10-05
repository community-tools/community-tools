defmodule CommunityToolsWeb.RoomController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Venues

  def index(conn, _params, current_user, claims) do
    rooms = Venues.list_rooms()
    render(conn, "index.html", rooms: rooms, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Venues.change_room(%CommunityTools.Venues.Room{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"room" => room_params}, current_user, claims) do
    case Venues.create_room(room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :show, room))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    room = Venues.get_room!(id)
    render(conn, "show.html", room: room, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    room = Venues.get_room!(id)
    changeset = Venues.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "room" => room_params}, current_user, claims) do
    room = Venues.get_room!(id)

    case Venues.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: room_path(conn, :show, room))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    room = Venues.get_room!(id)
    {:ok, _room} = Venues.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: room_path(conn, :index))
  end
end
