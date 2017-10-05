defmodule CommunityToolsWeb.OrganizationControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Organizations

  @create_attrs %{email: "some email", facebook: "some facebook", github: "some github", linkedin: "some linkedin", name: "some name", phone: "some phone", summary: "some summary", twitter: "some twitter", type: "some type", website: "some website"}
  @update_attrs %{email: "some updated email", facebook: "some updated facebook", github: "some updated github", linkedin: "some updated linkedin", name: "some updated name", phone: "some updated phone", summary: "some updated summary", twitter: "some updated twitter", type: "some updated type", website: "some updated website"}
  @invalid_attrs %{email: nil, facebook: nil, github: nil, linkedin: nil, name: nil, phone: nil, summary: nil, twitter: nil, type: nil, website: nil}

  def fixture(:organization) do
    {:ok, organization} = Organizations.create_organization(@create_attrs)
    organization
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, organization_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Organizations"
  end

  test "renders form for new organizations", %{conn: conn} do
    conn = get conn, organization_path(conn, :new)
    assert html_response(conn, 200) =~ "New Organization"
  end

  test "creates organization and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == organization_path(conn, :show, id)

    conn = get conn, organization_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Organization"
  end

  test "does not create organization and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, organization_path(conn, :create), organization: @invalid_attrs
    assert html_response(conn, 200) =~ "New Organization"
  end

  test "renders form for editing chosen organization", %{conn: conn} do
    organization = fixture(:organization)
    conn = get conn, organization_path(conn, :edit, organization)
    assert html_response(conn, 200) =~ "Edit Organization"
  end

  test "updates chosen organization and redirects when data is valid", %{conn: conn} do
    organization = fixture(:organization)
    conn = put conn, organization_path(conn, :update, organization), organization: @update_attrs
    assert redirected_to(conn) == organization_path(conn, :show, organization)

    conn = get conn, organization_path(conn, :show, organization)
    assert html_response(conn, 200) =~ "some updated email"
  end

  test "does not update chosen organization and renders errors when data is invalid", %{conn: conn} do
    organization = fixture(:organization)
    conn = put conn, organization_path(conn, :update, organization), organization: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Organization"
  end

  test "deletes chosen organization", %{conn: conn} do
    organization = fixture(:organization)
    conn = delete conn, organization_path(conn, :delete, organization)
    assert redirected_to(conn) == organization_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, organization_path(conn, :show, organization)
    end
  end
end
