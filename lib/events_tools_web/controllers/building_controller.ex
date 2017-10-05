defmodule CommunityToolsWeb.BuildingController do
  use CommunityToolsWeb, :controller

  import Ecto.Query, warn: false
  alias CommunityTools.Venues

  def index(conn, _params, current_user, claims) do
    buildings = Venues.list_buildings()
    render(conn, "index.html", buildings: buildings, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Venues.change_building(%CommunityTools.Venues.Building{})
    #building = %{ venue: []}
    #|> Repo.preload(:venue)
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"building" => building_params}, current_user, claims) do
    case Venues.create_building(building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building created successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    building = Venues.get_building!(id)
    render(conn, "show.html", building: building, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    building = Venues.get_building!(id)
    #|> Repo.preload(:venue)
    changeset = Venues.change_building(building)
    render(conn, "edit.html", building: building, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "building" => building_params}, current_user, claims) do
    building = Venues.get_building!(id)

    case Venues.update_building(building, building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building updated successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", building: building, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    building = Venues.get_building!(id)
    {:ok, _building} = Venues.delete_building(building)

    conn
    |> put_flash(:info, "Building deleted successfully.")
    |> redirect(to: building_path(conn, :index))
  end
end
