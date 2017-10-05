defmodule CommunityToolsWeb.CommentControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Comments

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:comment) do
    {:ok, comment} = Comments.create_comment(@create_attrs)
    comment
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, comment_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Comments"
  end

  test "renders form for new comments", %{conn: conn} do
    conn = get conn, comment_path(conn, :new)
    assert html_response(conn, 200) =~ "New Comment"
  end

  test "creates comment and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, comment_path(conn, :create), comment: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == comment_path(conn, :show, id)

    conn = get conn, comment_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Comment"
  end

  test "does not create comment and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, comment_path(conn, :create), comment: @invalid_attrs
    assert html_response(conn, 200) =~ "New Comment"
  end

  test "renders form for editing chosen comment", %{conn: conn} do
    comment = fixture(:comment)
    conn = get conn, comment_path(conn, :edit, comment)
    assert html_response(conn, 200) =~ "Edit Comment"
  end

  test "updates chosen comment and redirects when data is valid", %{conn: conn} do
    comment = fixture(:comment)
    conn = put conn, comment_path(conn, :update, comment), comment: @update_attrs
    assert redirected_to(conn) == comment_path(conn, :show, comment)

    conn = get conn, comment_path(conn, :show, comment)
    assert html_response(conn, 200) =~ "some updated body"
  end

  test "does not update chosen comment and renders errors when data is invalid", %{conn: conn} do
    comment = fixture(:comment)
    conn = put conn, comment_path(conn, :update, comment), comment: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Comment"
  end

  test "deletes chosen comment", %{conn: conn} do
    comment = fixture(:comment)
    conn = delete conn, comment_path(conn, :delete, comment)
    assert redirected_to(conn) == comment_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, comment_path(conn, :show, comment)
    end
  end
end
