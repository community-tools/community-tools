defmodule CommunityToolsWeb.VenueControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Venues

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:venue) do
    {:ok, venue} = Venues.create_venue(@create_attrs)
    venue
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, venue_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Venues"
  end

  test "renders form for new venues", %{conn: conn} do
    conn = get conn, venue_path(conn, :new)
    assert html_response(conn, 200) =~ "New Venue"
  end

  test "creates venue and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, venue_path(conn, :create), venue: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == venue_path(conn, :show, id)

    conn = get conn, venue_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Venue"
  end

  test "does not create venue and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, venue_path(conn, :create), venue: @invalid_attrs
    assert html_response(conn, 200) =~ "New Venue"
  end

  test "renders form for editing chosen venue", %{conn: conn} do
    venue = fixture(:venue)
    conn = get conn, venue_path(conn, :edit, venue)
    assert html_response(conn, 200) =~ "Edit Venue"
  end

  test "updates chosen venue and redirects when data is valid", %{conn: conn} do
    venue = fixture(:venue)
    conn = put conn, venue_path(conn, :update, venue), venue: @update_attrs
    assert redirected_to(conn) == venue_path(conn, :show, venue)

    conn = get conn, venue_path(conn, :show, venue)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen venue and renders errors when data is invalid", %{conn: conn} do
    venue = fixture(:venue)
    conn = put conn, venue_path(conn, :update, venue), venue: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Venue"
  end

  test "deletes chosen venue", %{conn: conn} do
    venue = fixture(:venue)
    conn = delete conn, venue_path(conn, :delete, venue)
    assert redirected_to(conn) == venue_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, venue_path(conn, :show, venue)
    end
  end
end
