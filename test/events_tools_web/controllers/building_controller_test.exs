defmodule CommunityToolsWeb.BuildingControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Venues

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:building) do
    {:ok, building} = Venues.create_building(@create_attrs)
    building
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, building_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Buildings"
  end

  test "renders form for new buildings", %{conn: conn} do
    conn = get conn, building_path(conn, :new)
    assert html_response(conn, 200) =~ "New Building"
  end

  test "creates building and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, building_path(conn, :create), building: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == building_path(conn, :show, id)

    conn = get conn, building_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Building"
  end

  test "does not create building and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, building_path(conn, :create), building: @invalid_attrs
    assert html_response(conn, 200) =~ "New Building"
  end

  test "renders form for editing chosen building", %{conn: conn} do
    building = fixture(:building)
    conn = get conn, building_path(conn, :edit, building)
    assert html_response(conn, 200) =~ "Edit Building"
  end

  test "updates chosen building and redirects when data is valid", %{conn: conn} do
    building = fixture(:building)
    conn = put conn, building_path(conn, :update, building), building: @update_attrs
    assert redirected_to(conn) == building_path(conn, :show, building)

    conn = get conn, building_path(conn, :show, building)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen building and renders errors when data is invalid", %{conn: conn} do
    building = fixture(:building)
    conn = put conn, building_path(conn, :update, building), building: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Building"
  end

  test "deletes chosen building", %{conn: conn} do
    building = fixture(:building)
    conn = delete conn, building_path(conn, :delete, building)
    assert redirected_to(conn) == building_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, building_path(conn, :show, building)
    end
  end
end
