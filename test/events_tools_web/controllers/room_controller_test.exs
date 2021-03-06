defmodule CommunityToolsWeb.RoomControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Venues

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:room) do
    {:ok, room} = Venues.create_room(@create_attrs)
    room
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, room_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Rooms"
  end

  test "renders form for new rooms", %{conn: conn} do
    conn = get conn, room_path(conn, :new)
    assert html_response(conn, 200) =~ "New Room"
  end

  test "creates room and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == room_path(conn, :show, id)

    conn = get conn, room_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Room"
  end

  test "does not create room and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @invalid_attrs
    assert html_response(conn, 200) =~ "New Room"
  end

  test "renders form for editing chosen room", %{conn: conn} do
    room = fixture(:room)
    conn = get conn, room_path(conn, :edit, room)
    assert html_response(conn, 200) =~ "Edit Room"
  end

  test "updates chosen room and redirects when data is valid", %{conn: conn} do
    room = fixture(:room)
    conn = put conn, room_path(conn, :update, room), room: @update_attrs
    assert redirected_to(conn) == room_path(conn, :show, room)

    conn = get conn, room_path(conn, :show, room)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen room and renders errors when data is invalid", %{conn: conn} do
    room = fixture(:room)
    conn = put conn, room_path(conn, :update, room), room: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Room"
  end

  test "deletes chosen room", %{conn: conn} do
    room = fixture(:room)
    conn = delete conn, room_path(conn, :delete, room)
    assert redirected_to(conn) == room_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, room_path(conn, :show, room)
    end
  end
end
