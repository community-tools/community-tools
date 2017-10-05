defmodule CommunityToolsWeb.HallControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Venues

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:hall) do
    {:ok, hall} = Venues.create_hall(@create_attrs)
    hall
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hall_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Halls"
  end

  test "renders form for new halls", %{conn: conn} do
    conn = get conn, hall_path(conn, :new)
    assert html_response(conn, 200) =~ "New Hall"
  end

  test "creates hall and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, hall_path(conn, :create), hall: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == hall_path(conn, :show, id)

    conn = get conn, hall_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Hall"
  end

  test "does not create hall and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hall_path(conn, :create), hall: @invalid_attrs
    assert html_response(conn, 200) =~ "New Hall"
  end

  test "renders form for editing chosen hall", %{conn: conn} do
    hall = fixture(:hall)
    conn = get conn, hall_path(conn, :edit, hall)
    assert html_response(conn, 200) =~ "Edit Hall"
  end

  test "updates chosen hall and redirects when data is valid", %{conn: conn} do
    hall = fixture(:hall)
    conn = put conn, hall_path(conn, :update, hall), hall: @update_attrs
    assert redirected_to(conn) == hall_path(conn, :show, hall)

    conn = get conn, hall_path(conn, :show, hall)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen hall and renders errors when data is invalid", %{conn: conn} do
    hall = fixture(:hall)
    conn = put conn, hall_path(conn, :update, hall), hall: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Hall"
  end

  test "deletes chosen hall", %{conn: conn} do
    hall = fixture(:hall)
    conn = delete conn, hall_path(conn, :delete, hall)
    assert redirected_to(conn) == hall_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, hall_path(conn, :show, hall)
    end
  end
end
