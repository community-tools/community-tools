defmodule CommunityToolsWeb.SponsorshipOptionController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Sponsors
  alias CommunityTools.Sponsors.SponsorshipOption


  def index(conn, _params, current_user, _claims) do
    sponsorship_options = Sponsors.list_sponsorship_options()
    render(conn, "index.html", sponsorship_options: sponsorship_options, current_user: current_user)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Sponsors.change_sponsorship_option(%SponsorshipOption{})
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"sponsorship_option" => sponsorship_option_params}, current_user, _claims) do
    case Sponsors.create_sponsorship_option(sponsorship_option_params) do
      {:ok, sponsorship_option} ->
        conn
        |> put_flash(:info, "Sponsorship Option created successfully.")
        |> redirect(to: sponsorship_option_path(conn, :show, sponsorship_option))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    sponsorship_option = Sponsors.get_sponsorship_option!(id)
    render(conn, "show.html", sponsorship_option: sponsorship_option, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    sponsorship_option = Sponsors.get_sponsorship_option!(id)
    changeset = Sponsors.change_sponsorship_option(sponsorship_option)
    render(conn, "edit.html", sponsorship_option: sponsorship_option, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "sponsorship_option" => sponsorship_option_params}, current_user, _claims) do
    sponsorship_option = Sponsors.get_sponsorship_option!(id)

    case Sponsors.update_sponsorship_option(sponsorship_option, sponsorship_option_params) do
      {:ok, sponsorship_option} ->
        conn
        |> put_flash(:info, "Sponsorship Option updated successfully.")
        |> redirect(to: sponsorship_option_path(conn, :show, sponsorship_option))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sponsorship_option: sponsorship_option, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    sponsorship_option = Sponsors.get_sponsorship_option!(id)
    {:ok, _sponsorship_option} = Sponsors.delete_sponsorship_option(sponsorship_option)

    conn
    |> put_flash(:info, "Sponsorship Option deleted successfully.")
    |> redirect(to: sponsorship_option_path(conn, :index))
  end
end
