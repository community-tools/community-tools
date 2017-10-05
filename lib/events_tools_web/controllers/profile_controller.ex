defmodule CommunityToolsWeb.ProfileController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Accounts
  alias CommunityTools.Accounts.Profile
  alias CommunityTools.Status
  alias CommunityTools.Repo

  def index(conn, _params, current_user, claims) do
    profiles = Accounts.list_profiles()
    render(conn, "index.html", profiles: profiles, current_user: current_user, claims: claims)
  end

  def team(conn, _params, current_user, claims) do
    profiles = Accounts.list_team()
    status_all = Status.all_status
    render(conn, "team.html", profiles: profiles, status_all: status_all, current_user: current_user, claims: claims)
  end


  def new(conn, _params, current_user, _claims) do
    changeset = Accounts.change_profile(%CommunityTools.Accounts.Profile{})
    profile = %{status: [], user_id: current_user.id}
    status_all = Status.all_status
    render(conn, "new.html", changeset: changeset, profile: profile, status_all: status_all, current_user: current_user)
  end

  def create(conn, %{"profile" => profile_params}, current_user, claims) do
    user = Accounts.get_user!(current_user.id)
    case Accounts.create_profile(profile_params, user) do
      {:ok, profile} ->
        profile = Accounts.Profile.avatar_changeset(profile, profile_params)
        |> Repo.update
        conn
        |> put_flash(:info, "Profile created successfully.")
        |> redirect(to: accounts_path(conn, :dashboard))
      {:error, %Ecto.Changeset{} = changeset} ->
        status_all = Status.all_status
        profile = %{status: [], user_id: current_user.id}
        render(conn, "new.html", changeset: changeset, profile: profile, status_all: status_all, current_user: current_user, claims: claims)
    end
  end


  def profile(conn, _params,  current_user, claims) do
    #profile = Repo.get_by!(Profile, slug: id)
    #render(conn, "profile.html", current_user: get_session(conn, :current_user))

    profile = Repo.get_by(Profile, user_id: current_user.id)
    case Repo.get_by(Profile, user_id: current_user.id) do
      nil ->
        changeset = Accounts.change_profile(%CommunityTools.Accounts.Profile{})
        profile = %{status: []}
        status_all = Status.all_status
        render(conn, "missing.html", changeset: changeset, profile: profile, status_all: status_all, current_user: current_user, claims: claims)
      record ->
        profile = Repo.get_by!(Profile, user_id: current_user.id)
        |> Repo.preload(:presentations)
        |> Repo.preload(:status)
         render(conn, "show.html", profile: profile, current_user: current_user, claims: claims)
    end

  end

  def show(conn, %{"id" => id}, current_user, claims) do
    #profile = Accounts.get_profile!(id)
    profile = Repo.get_by!(Profile, slug: id)
    |> Repo.preload(:presentations)
    |> Repo.preload(:status)
    status_all = Status.all_status
    render(conn, "show.html", profile: profile, status_all: status_all, current_user: current_user, claims: claims)
  end


  def edit(conn, %{"id" => id}, current_user, claims) do
    #profile = Accounts.get_profile!(id)
    profile = Repo.get_by!(Profile, slug: id)
    |> Repo.preload(:status)
    changeset = Accounts.change_profile(profile)
    status_all = Status.all_status
    render(conn, "edit.html", profile: profile, changeset: changeset, status_all: status_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}, current_user, claims) do
    profile = Accounts.get_profile!(id)
    |> Repo.preload(:status)

    case Accounts.update_profile(profile, profile_params, current_user) do
      {:ok, profile} ->
        profile = Profile.avatar_changeset(profile, profile_params)
        |> Repo.update
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: accounts_path(conn, :dashboard))
      {:error, %Ecto.Changeset{} = changeset} ->
        status_all = Status.all_status
        render(conn, "edit.html", profile: profile, changeset: changeset, status_all: status_all, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    profile = Accounts.get_profile!(id)
    {:ok, _profile} = Accounts.delete_profile(profile)

    conn
    |> put_flash(:info, "Profile deleted successfully.")
    |> redirect(to: accounts_path(conn, :dashboard))
  end
end
