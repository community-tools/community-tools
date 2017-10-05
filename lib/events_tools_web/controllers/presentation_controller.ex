defmodule CommunityToolsWeb.PresentationController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Repo
  alias CommunityTools.Presentations
  alias CommunityTools.Presentations.Presentation
  alias CommunityTools.Accounts
  alias CommunityTools.Events


  def index(conn, _params, current_user, claims) do
    presentations = Presentations.list_presentations()
    render(conn, "index.html", presentations: presentations, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Presentations.change_presentation(%CommunityTools.Presentations.Presentation{})
    presentation = %{presenters: [], events: [], owners: []}
    profiles_all = Accounts.all_profiles
    events_all = Events.all_events
    render(conn, "new.html", changeset: changeset, presentation: presentation, profiles_all: profiles_all, events_all: events_all, current_user: current_user, claims: claims)
  end

  def cfp(conn, _params, current_user, claims) do
    changeset = Presentations.change_presentation(%CommunityTools.Presentations.Presentation{})
    presentation = %{presenters: [], events: []}
    profiles_all = Accounts.all_profiles
    events_all = Events.all_events
    render(conn, "cfp.html", changeset: changeset, presentation: presentation, profiles_all: profiles_all, events_all: events_all, current_user: current_user, claims: claims)
    #render(conn, "new.html", changeset: changeset, presentation: presentation, profiles_all: profiles_all, events_all: events_all, current_user: current_user)
  end

  def create(conn, %{"presentation" => presentation_params}, current_user, claims) do
    #owner = Accounts.get_user!(current_user.id)
    owner = Accounts.get_user!(current_user.id)
    #Presentations.create_presentation(presentation_params, owner)
    #conn
    #|> redirect(to: presentation_path(conn, :index))
    case Presentations.create_presentation(presentation_params, owner) do
     {:ok, presentation} ->
        conn
        |> put_flash(:info, "Presentation created successfully.")
        |> redirect(to: presentation_path(conn, :show, presentation))
      {:error, %Ecto.Changeset{} = changeset} ->
        presentation = %{presenters: [], events: []}
        profiles_all = Accounts.all_profiles
        events_all = Events.all_events
        render(conn, "cfp.html", changeset: changeset, presentation: presentation, profiles_all: profiles_all, events_all: events_all, current_user: current_user, claims: claims)
   end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    #presentation = Presentations.get_presentation!(id)
    presentation = Repo.get_by!(Presentation, slug: id)
    |> Repo.preload(:presenters)
    |> Repo.preload(:events)
    |> Repo.preload(:owners)
    render(conn, "show.html", presentation: presentation, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    #presentation = Presentations.get_presentation!(id)
    presentation = Repo.get_by!(Presentation, slug: id)
    |> Repo.preload(:presenters)
    |> Repo.preload(:events)
    |> Repo.preload(:owners)
    changeset = Presentations.change_presentation(presentation)
    profiles_all = Accounts.all_profiles
    events_all = Events.all_events
    render(conn, "edit.html", presentation: presentation, changeset: changeset, profiles_all: profiles_all, events_all: events_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "presentation" => presentation_params}, current_user, claims) do
    #presentation = Presentations.get_presentation!(id)
    presentation = Repo.get_by!(Presentation, slug: id)

    case Presentations.update_presentation(presentation, presentation_params) do
      {:ok, presentation} ->
        conn
        |> put_flash(:info, "Presentation updated successfully.")
        |> redirect(to: presentation_path(conn, :show, presentation))
      {:error, %Ecto.Changeset{} = changeset} ->
        profiles_all = Accounts.all_profiles
        events_all = Events.all_events
        render(conn, "edit.html", presentation: presentation, changeset: changeset, profiles_all: profiles_all, events_all: events_all, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    presentation = Presentations.get_presentation!(id)
    {:ok, _presentation} = Presentations.delete_presentation(presentation)

    conn
    |> put_flash(:info, "Presentation deleted successfully.")
    |> redirect(to: presentation_path(conn, :index))
  end
end
