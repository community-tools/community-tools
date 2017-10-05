defmodule CommunityToolsWeb.TagController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Tags

  def index(conn, _params, current_user, claims) do
    tags = Tags.list_tags()
    render(conn, "index.html", tags: tags, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Tags.change_tag(%CommunityTools.Tags.Tag{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"tag" => tag_params}, current_user, claims) do
    case Tags.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: tag_path(conn, :show, tag))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    tag = Tags.get_tag!(id)
    render(conn, "show.html", tag: tag, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    tag = Tags.get_tag!(id)
    changeset = Tags.change_tag(tag)
    render(conn, "edit.html", tag: tag, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}, current_user, claims) do
    tag = Tags.get_tag!(id)

    case Tags.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: tag_path(conn, :show, tag))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    tag = Tags.get_tag!(id)
    {:ok, _tag} = Tags.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: tag_path(conn, :index))
  end
end
