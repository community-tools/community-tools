defmodule CommunityToolsWeb.SponsorController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Sponsors
  alias CommunityTools.Organizations.Organization
  alias CommunityTools.Sponsors.SponsorshipOption

  alias CommunityTools.Repo

  def index(conn, _params, current_user, claims) do
    sponsors = Sponsors.list_sponsors()
    render(conn, "index.html", sponsors: sponsors, current_user: current_user, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Sponsors.change_sponsor(%CommunityTools.Sponsors.Sponsor{organization: [], sponsorship_option: []})
    sponsor = %{organization: [], sponsorship_option: []}
    sponsorship_options_all = Repo.all(SponsorshipOption)
    organizations_all = Repo.all(Organization)
    render(conn, "new.html", changeset: changeset, sponsor: sponsor, organizations_all: organizations_all, sponsorship_options_all: sponsorship_options_all, current_user: current_user, claims: claims)
  end

  def create(conn, %{"sponsor" => sponsor_params}, current_user, claims) do
    case Sponsors.create_sponsor(sponsor_params) do
      {:ok, sponsor} ->
        conn
        |> put_flash(:info, "Sponsor created successfully.")
        |> redirect(to: sponsor_path(conn, :show, sponsor))
      {:error, %Ecto.Changeset{} = changeset} ->
        sponsorship_options_all = Repo.all(SponsorshipOption)
        organizations_all = Repo.all(Organization)
        render(conn, "new.html", changeset: changeset, organizations_all: organizations_all, sponsorship_options_all: sponsorship_options_all, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    sponsor = Sponsors.get_sponsor!(id)
    render(conn, "show.html", sponsor: sponsor, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    sponsor = Sponsors.get_sponsor!(id)
    #|> Repo.preload(:organization)
    |> Repo.preload(:sponsorship_option)
    changeset = Sponsors.change_sponsor(sponsor)
    sponsorship_options_all = Repo.all(SponsorshipOption)
    organizations_all = Repo.all(Organization)
    render(conn, "edit.html", sponsor: sponsor, changeset: changeset, organizations_all: organizations_all, sponsorship_options_all: sponsorship_options_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "sponsor" => sponsor_params}, current_user, claims) do
    sponsor = Sponsors.get_sponsor!(id)

    case Sponsors.update_sponsor(sponsor, sponsor_params) do
      {:ok, sponsor} ->
        conn
        |> put_flash(:info, "Sponsor updated successfully.")
        |> redirect(to: sponsor_path(conn, :show, sponsor))
      {:error, %Ecto.Changeset{} = changeset} ->
        sponsorship_options_all = Repo.all(SponsorshipOption)
        organizations_all = Repo.all(Organization)
        render(conn, "edit.html", sponsor: sponsor, changeset: changeset, organizations_all: organizations_all, sponsorship_options_all: sponsorship_options_all, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    sponsor = Sponsors.get_sponsor!(id)
    {:ok, _sponsor} = Sponsors.delete_sponsor(sponsor)

    conn
    |> put_flash(:info, "Sponsor deleted successfully.")
    |> redirect(to: sponsor_path(conn, :index))
  end
end
