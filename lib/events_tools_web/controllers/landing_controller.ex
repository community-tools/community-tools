  defmodule CommunityToolsWeb.LandingController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Events

  def homepage(conn, _params, current_user, claims) do
    events = Events.list_events()
    render(conn, "homepage.html", events: events, current_user: current_user, claims: claims)

  end

  def about(conn, _params, current_user, claims) do
    render(conn, "about.html", current_user: current_user, claims: claims)
  end

  def index(conn, _params, current_user, claims) do
    render(conn, "index.html", current_user: current_user, claims: claims)
  end

  def location(conn, _params, current_user, claims) do
    render(conn, "location.html", current_user: current_user, claims: claims)
  end

  def presentations(conn, _params, current_user, claims) do
    render(conn, "presentations.html", current_user: current_user, claims: claims)
  end

  def speakers(conn, _params, current_user, claims) do
    render(conn, "speakers.html", current_user: current_user, claims: claims)
  end

  def schedule(conn, _params, current_user, claims) do
    render(conn, "schedule.html", current_user: current_user, claims: claims)
  end

  def team(conn, _params, current_user, claims) do
    render(conn, "team.html", current_user: current_user, claims: claims)
  end

end
