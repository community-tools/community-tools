defmodule CommunityToolsWeb.AdminController do
  use CommunityToolsWeb, :controller

  def admin(conn, _params) do
      render conn, "dashboard.html"
  end

end
