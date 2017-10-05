defmodule CommunityToolsWeb.StatusControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Status

  @create_attrs %{summary: "some summary", title: "some title"}
  @update_attrs %{summary: "some updated summary", title: "some updated title"}
  @invalid_attrs %{summary: nil, title: nil}

  def fixture(:status) do
    {:ok, status} = Status.create_status(@create_attrs)
    status
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, status_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Status"
  end

  test "renders form for new status", %{conn: conn} do
    conn = get conn, status_path(conn, :new)
    assert html_response(conn, 200) =~ "New Status"
  end

  test "creates status and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, status_path(conn, :create), status: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == status_path(conn, :show, id)

    conn = get conn, status_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Status"
  end

  test "does not create status and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, status_path(conn, :create), status: @invalid_attrs
    assert html_response(conn, 200) =~ "New Status"
  end

  test "renders form for editing chosen status", %{conn: conn} do
    status = fixture(:status)
    conn = get conn, status_path(conn, :edit, status)
    assert html_response(conn, 200) =~ "Edit Status"
  end

  test "updates chosen status and redirects when data is valid", %{conn: conn} do
    status = fixture(:status)
    conn = put conn, status_path(conn, :update, status), status: @update_attrs
    assert redirected_to(conn) == status_path(conn, :show, status)

    conn = get conn, status_path(conn, :show, status)
    assert html_response(conn, 200) =~ "some updated summary"
  end

  test "does not update chosen status and renders errors when data is invalid", %{conn: conn} do
    status = fixture(:status)
    conn = put conn, status_path(conn, :update, status), status: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Status"
  end

  test "deletes chosen status", %{conn: conn} do
    status = fixture(:status)
    conn = delete conn, status_path(conn, :delete, status)
    assert redirected_to(conn) == status_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, status_path(conn, :show, status)
    end
  end
end
