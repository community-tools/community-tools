defmodule CommunityToolsWeb.EventController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Events
  alias CommunityTools.Events.Event
  alias CommunityTools.Accounts
  alias CommunityTools.Repo

  def index(conn, _params, current_user, claims) do
    events = Events.list_events()
    render conn, "index.html", events: events, current_user: current_user, claims: claims
  end

  def new(conn, _params, current_user, claims) do
    changeset = Events.change_event(%Event{})
    event = %{organizers: []}
    organizers_all = Repo.all(CommunityTools.Accounts.Profile)
    render(conn, "new.html", changeset: changeset, event: event, organizers_all: organizers_all, current_user: current_user, claims: claims)
  end

  def create(conn, %{"event" => event_params}, current_user, claims) do
    case Events.create_event(event_params) do
      #IO.inspect conn
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, %Ecto.Changeset{} = changeset} ->
        event = %{organizers: []}
        organizers_all = Accounts.list_team
        render(conn, "new.html", changeset: changeset, event: event,  organizers_all: organizers_all, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    event = Repo.get_by!(Event, slug: id)
    |> Repo.preload(:presentations)
    |> Repo.preload(presentations: :presenters)
    |> Repo.preload(:posts)
    |> Repo.preload(:organizers)
    render(conn, "show.html", event: event, current_user: current_user, claims: claims)
  end


  def angular(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("angular-camp"), current_user: current_user, claims: claims)
  end

  def apps(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("apps-camp"), current_user: current_user, claims: claims)
  end

  def arvr(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("arvr-camp"), current_user: current_user, claims: claims)
  end

  def biotech(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("biotech"), current_user: current_user, claims: claims)
  end

  def capital(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("capitalcamp"), current_user: current_user, claims: claims)
  end

  def dataviz(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("dataviz-camp"), current_user: current_user, claims: claims)
  end

  def design(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event("design-camp"), current_user: current_user, claims: claims)
  end

  def elixir(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("elixir-camp"), current_user: current_user, claims: claims)
  end

  def go(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("go-camp"), current_user: current_user, claims: claims)
  end

  def nextgen(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("nextgen-camp"), current_user: current_user, claims: claims)
  end

  def node(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("node-camp"), current_user: current_user, claims: claims)
  #IO.inspect conn
  end

  def phoenix(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("phoenix-camp"), current_user: current_user, claims: claims)
  end

  def react(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("react-camp"), current_user: current_user, claims: claims)
  end

  def women(conn, _params, current_user, claims) do
    render(conn, "show.html", event: Events.get_event!("women-in-open-source-camp"), current_user: current_user, claims: claims)
  end


  def edit(conn, %{"id" => id}, current_user, claims) do
      event = Events.get_event!(id)
      |> Repo.preload(:organizers)
      changeset = Events.change_event(event)
      organizers_all = Accounts.list_team
      render(conn, "edit.html", event: event, changeset: changeset, organizers_all: organizers_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "event" => event_params}, current_user, claims) do
    event = Events.get_event!(id)

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event Updated")
        |> redirect(to: event_path(conn, :show, event))
      {:error, %Ecto.Changeset{} = changeset} ->
        organizers_all = Repo.all(CommunityTools.Accounts.Profile)
        render(conn, "edit.html", event: event, changeset: changeset, organizers_all: organizers_all, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    event = Events.get_event!(id)
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event Deleted")
    |>redirect(to: event_path(conn, :index))

  end

  def admin(conn, _params, current_user, claims) do
      events = CommunityTools.Events.list_events
      render conn, "admin-list.html", events: events, current_user: current_user, claims: claims

  end

end
