defmodule CommunityToolsWeb.SponsorControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Sponsors

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:sponsor) do
    {:ok, sponsor} = Sponsors.create_sponsor(@create_attrs)
    sponsor
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sponsor_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Sponsors"
  end

  test "renders form for new sponsors", %{conn: conn} do
    conn = get conn, sponsor_path(conn, :new)
    assert html_response(conn, 200) =~ "New Sponsor"
  end

  test "creates sponsor and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, sponsor_path(conn, :create), sponsor: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == sponsor_path(conn, :show, id)

    conn = get conn, sponsor_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Sponsor"
  end

  test "does not create sponsor and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sponsor_path(conn, :create), sponsor: @invalid_attrs
    assert html_response(conn, 200) =~ "New Sponsor"
  end

  test "renders form for editing chosen sponsor", %{conn: conn} do
    sponsor = fixture(:sponsor)
    conn = get conn, sponsor_path(conn, :edit, sponsor)
    assert html_response(conn, 200) =~ "Edit Sponsor"
  end

  test "updates chosen sponsor and redirects when data is valid", %{conn: conn} do
    sponsor = fixture(:sponsor)
    conn = put conn, sponsor_path(conn, :update, sponsor), sponsor: @update_attrs
    assert redirected_to(conn) == sponsor_path(conn, :show, sponsor)

    conn = get conn, sponsor_path(conn, :show, sponsor)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen sponsor and renders errors when data is invalid", %{conn: conn} do
    sponsor = fixture(:sponsor)
    conn = put conn, sponsor_path(conn, :update, sponsor), sponsor: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Sponsor"
  end

  test "deletes chosen sponsor", %{conn: conn} do
    sponsor = fixture(:sponsor)
    conn = delete conn, sponsor_path(conn, :delete, sponsor)
    assert redirected_to(conn) == sponsor_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, sponsor_path(conn, :show, sponsor)
    end
  end
end
