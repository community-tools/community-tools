defmodule CommunityToolsWeb.TechnologyController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Tags
  alias CommunityTools.Tags.Technology

  def index(conn, _params, current_user, claims) do
    technologies = Tags.list_technologies()
    render(conn, "index.html", technologies: technologies)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Tags.change_technology(%Technology{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"technology" => technology_params}, current_user, claims) do
    case Tags.create_technology(technology_params) do
      {:ok, technology} ->
        conn
        |> put_flash(:info, "Technology created successfully.")
        |> redirect(to: technology_path(conn, :show, technology))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    technology = Tags.get_technology!(id)
    render(conn, "show.html", technology: technology)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    technology = Tags.get_technology!(id)
    changeset = Tags.change_technology(technology)
    render(conn, "edit.html", technology: technology, changeset: changeset)
  end

  def update(conn, %{"id" => id, "technology" => technology_params}, current_user, claims) do
    technology = Tags.get_technology!(id)

    case Tags.update_technology(technology, technology_params) do
      {:ok, technology} ->
        conn
        |> put_flash(:info, "Technology updated successfully.")
        |> redirect(to: technology_path(conn, :show, technology))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", technology: technology, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    technology = Tags.get_technology!(id)
    {:ok, _technology} = Tags.delete_technology(technology)

    conn
    |> put_flash(:info, "Technology deleted successfully.")
    |> redirect(to: technology_path(conn, :index))
  end
end
