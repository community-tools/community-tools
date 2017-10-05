defmodule CommunityToolsWeb.SponsorshipControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Sponsors

  @create_attrs %{camps: "some camps", expo: "some expo", name: "some name", price: "120.5", program: "some program", recruiting: "some recruiting", signage: "some signage", social: "some social", stock: 42, summary: "some summary", swag: "some swag", type: "some type", website: "some website"}
  @update_attrs %{camps: "some updated camps", expo: "some updated expo", name: "some updated name", price: "456.7", program: "some updated program", recruiting: "some updated recruiting", signage: "some updated signage", social: "some updated social", stock: 43, summary: "some updated summary", swag: "some updated swag", type: "some updated type", website: "some updated website"}
  @invalid_attrs %{camps: nil, expo: nil, name: nil, price: nil, program: nil, recruiting: nil, signage: nil, social: nil, stock: nil, summary: nil, swag: nil, type: nil, website: nil}

  def fixture(:sponsorship) do
    {:ok, sponsorship} = Sponsors.create_sponsorship(@create_attrs)
    sponsorship
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sponsorship_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Sponsorships"
  end

  test "renders form for new sponsorships", %{conn: conn} do
    conn = get conn, sponsorship_path(conn, :new)
    assert html_response(conn, 200) =~ "New Sponsorship"
  end

  test "creates sponsorship and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, sponsorship_path(conn, :create), sponsorship: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == sponsorship_path(conn, :show, id)

    conn = get conn, sponsorship_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Sponsorship"
  end

  test "does not create sponsorship and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sponsorship_path(conn, :create), sponsorship: @invalid_attrs
    assert html_response(conn, 200) =~ "New Sponsorship"
  end

  test "renders form for editing chosen sponsorship", %{conn: conn} do
    sponsorship = fixture(:sponsorship)
    conn = get conn, sponsorship_path(conn, :edit, sponsorship)
    assert html_response(conn, 200) =~ "Edit Sponsorship"
  end

  test "updates chosen sponsorship and redirects when data is valid", %{conn: conn} do
    sponsorship = fixture(:sponsorship)
    conn = put conn, sponsorship_path(conn, :update, sponsorship), sponsorship: @update_attrs
    assert redirected_to(conn) == sponsorship_path(conn, :show, sponsorship)

    conn = get conn, sponsorship_path(conn, :show, sponsorship)
    assert html_response(conn, 200) =~ "some updated camps"
  end

  test "does not update chosen sponsorship and renders errors when data is invalid", %{conn: conn} do
    sponsorship = fixture(:sponsorship)
    conn = put conn, sponsorship_path(conn, :update, sponsorship), sponsorship: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Sponsorship"
  end

  test "deletes chosen sponsorship", %{conn: conn} do
    sponsorship = fixture(:sponsorship)
    conn = delete conn, sponsorship_path(conn, :delete, sponsorship)
    assert redirected_to(conn) == sponsorship_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, sponsorship_path(conn, :show, sponsorship)
    end
  end
end
