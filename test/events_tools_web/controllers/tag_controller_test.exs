defmodule CommunityToolsWeb.TagControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Tags

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:tag) do
    {:ok, tag} = Tags.create_tag(@create_attrs)
    tag
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tag_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Tags"
  end

  test "renders form for new tags", %{conn: conn} do
    conn = get conn, tag_path(conn, :new)
    assert html_response(conn, 200) =~ "New Tag"
  end

  test "creates tag and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, tag_path(conn, :create), tag: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == tag_path(conn, :show, id)

    conn = get conn, tag_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Tag"
  end

  test "does not create tag and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tag_path(conn, :create), tag: @invalid_attrs
    assert html_response(conn, 200) =~ "New Tag"
  end

  test "renders form for editing chosen tag", %{conn: conn} do
    tag = fixture(:tag)
    conn = get conn, tag_path(conn, :edit, tag)
    assert html_response(conn, 200) =~ "Edit Tag"
  end

  test "updates chosen tag and redirects when data is valid", %{conn: conn} do
    tag = fixture(:tag)
    conn = put conn, tag_path(conn, :update, tag), tag: @update_attrs
    assert redirected_to(conn) == tag_path(conn, :show, tag)

    conn = get conn, tag_path(conn, :show, tag)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen tag and renders errors when data is invalid", %{conn: conn} do
    tag = fixture(:tag)
    conn = put conn, tag_path(conn, :update, tag), tag: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Tag"
  end

  test "deletes chosen tag", %{conn: conn} do
    tag = fixture(:tag)
    conn = delete conn, tag_path(conn, :delete, tag)
    assert redirected_to(conn) == tag_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, tag_path(conn, :show, tag)
    end
  end
end
