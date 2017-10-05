defmodule CommunityToolsWeb.Hall_Room_PlanControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Venues

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:hall__room__plan) do
    {:ok, hall__room__plan} = Venues.create_hall__room__plan(@create_attrs)
    hall__room__plan
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hall__room__plan_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Hall room plans"
  end

  test "renders form for new hall_room_plans", %{conn: conn} do
    conn = get conn, hall__room__plan_path(conn, :new)
    assert html_response(conn, 200) =~ "New Hall  room  plan"
  end

  test "creates hall__room__plan and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, hall__room__plan_path(conn, :create), hall__room__plan: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == hall__room__plan_path(conn, :show, id)

    conn = get conn, hall__room__plan_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Hall  room  plan"
  end

  test "does not create hall__room__plan and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hall__room__plan_path(conn, :create), hall__room__plan: @invalid_attrs
    assert html_response(conn, 200) =~ "New Hall  room  plan"
  end

  test "renders form for editing chosen hall__room__plan", %{conn: conn} do
    hall__room__plan = fixture(:hall__room__plan)
    conn = get conn, hall__room__plan_path(conn, :edit, hall__room__plan)
    assert html_response(conn, 200) =~ "Edit Hall  room  plan"
  end

  test "updates chosen hall__room__plan and redirects when data is valid", %{conn: conn} do
    hall__room__plan = fixture(:hall__room__plan)
    conn = put conn, hall__room__plan_path(conn, :update, hall__room__plan), hall__room__plan: @update_attrs
    assert redirected_to(conn) == hall__room__plan_path(conn, :show, hall__room__plan)

    conn = get conn, hall__room__plan_path(conn, :show, hall__room__plan)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen hall__room__plan and renders errors when data is invalid", %{conn: conn} do
    hall__room__plan = fixture(:hall__room__plan)
    conn = put conn, hall__room__plan_path(conn, :update, hall__room__plan), hall__room__plan: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Hall  room  plan"
  end

  test "deletes chosen hall__room__plan", %{conn: conn} do
    hall__room__plan = fixture(:hall__room__plan)
    conn = delete conn, hall__room__plan_path(conn, :delete, hall__room__plan)
    assert redirected_to(conn) == hall__room__plan_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, hall__room__plan_path(conn, :show, hall__room__plan)
    end
  end
end
