defmodule CommunityToolsWeb.AuthorizationController do
  use CommunityToolsWeb, :controller
  use Guardian.Phoenix.Controller
  use Ecto.Schema

  alias CommunityTools.Repo
  #alias CommunityTools.Accounts.Authorization

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html", current_user: current_user, authorizations: authorizations(current_user)
  end

  defp authorizations(user) do
    Ecto.Schema.assoc(user, :authorizations)
    |> Repo.all
  end
end
