defmodule CommunityToolsWeb.VenueController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Venues

  def index(conn, _params, current_user, claims) do
    venues = Venues.list_venues()
    render(conn, "index.html", venues: venues, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Venues.change_venue(%CommunityTools.Venues.Venue{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"venue" => venue_params}, current_user, claims) do
    case Venues.create_venue(venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue created successfully.")
        |> redirect(to: venue_path(conn, :show, venue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    venue = Venues.get_venue!(id)
    render(conn, "show.html", venue: venue, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    venue = Venues.get_venue!(id)
    changeset = Venues.change_venue(venue)
    render(conn, "edit.html", venue: venue, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}, current_user, claims) do
    venue = Venues.get_venue!(id)

    case Venues.update_venue(venue, venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue updated successfully.")
        |> redirect(to: venue_path(conn, :show, venue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", venue: venue, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    venue = Venues.get_venue!(id)
    {:ok, _venue} = Venues.delete_venue(venue)

    conn
    |> put_flash(:info, "Venue deleted successfully.")
    |> redirect(to: venue_path(conn, :index))
  end
end
