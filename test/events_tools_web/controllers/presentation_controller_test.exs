defmodule CommunityToolsWeb.PresentationControllerTest do
  use CommunityToolsWeb.ConnCase

  alias CommunityTools.Presentations

  @create_attrs %{slides: "some slides", summary: "some summary", title: "some title"}
  @update_attrs %{slides: "some updated slides", summary: "some updated summary", title: "some updated title"}
  @invalid_attrs %{slides: nil, summary: nil, title: nil}

  def fixture(:presentation) do
    {:ok, presentation} = Presentations.create_presentation(@create_attrs)
    presentation
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, presentation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Presentations"
  end

  test "renders form for new presentations", %{conn: conn} do
    conn = get conn, presentation_path(conn, :new)
    assert html_response(conn, 200) =~ "New Presentation"
  end

  test "creates presentation and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, presentation_path(conn, :create), presentation: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == presentation_path(conn, :show, id)

    conn = get conn, presentation_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Presentation"
  end

  test "does not create presentation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, presentation_path(conn, :create), presentation: @invalid_attrs
    assert html_response(conn, 200) =~ "New Presentation"
  end

  test "renders form for editing chosen presentation", %{conn: conn} do
    presentation = fixture(:presentation)
    conn = get conn, presentation_path(conn, :edit, presentation)
    assert html_response(conn, 200) =~ "Edit Presentation"
  end

  test "updates chosen presentation and redirects when data is valid", %{conn: conn} do
    presentation = fixture(:presentation)
    conn = put conn, presentation_path(conn, :update, presentation), presentation: @update_attrs
    assert redirected_to(conn) == presentation_path(conn, :show, presentation)

    conn = get conn, presentation_path(conn, :show, presentation)
    assert html_response(conn, 200) =~ "some updated slides"
  end

  test "does not update chosen presentation and renders errors when data is invalid", %{conn: conn} do
    presentation = fixture(:presentation)
    conn = put conn, presentation_path(conn, :update, presentation), presentation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Presentation"
  end

  test "deletes chosen presentation", %{conn: conn} do
    presentation = fixture(:presentation)
    conn = delete conn, presentation_path(conn, :delete, presentation)
    assert redirected_to(conn) == presentation_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, presentation_path(conn, :show, presentation)
    end
  end
end
