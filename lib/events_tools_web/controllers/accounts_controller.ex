defmodule CommunityToolsWeb.AccountsController do
  use CommunityToolsWeb, :controller
  plug Ueberauth

  alias CommunityTools.UserFromAuth
  alias CommunityTools.Accounts
  alias CommunityTools.Accounts.User
  alias CommunityTools.Accounts.Profile
  alias CommunityTools.Presentations
  alias CommunityTools.Repo
  use Ecto.Schema


  def callback(conn, params) do
    IO.puts "+++++"
    IO.inspect(conn.assigns)
    IO.puts "+++++"
    IO.inspect(params)
    IO.puts "+++++"
  end


  def signin(conn, _params, current_user, claims) do
    #render conn, "signin.html", current_user: current_user, current_auths: auths(current_user)
    #IO.inspect conn
    render(conn, "signin.html", current_user: current_user, claims: claims)
  end

  def dashboard(conn, _params, current_user, claims) do
    #render conn, "signin.html", current_user: current_user, current_auths: auths(current_user)
    #IO.inspect conn

    #profile = Repo.get_by(Profile, user_id: current_user.id)
    profiles = Accounts.get_profiles_by_user(current_user.id)
    presentations = Presentations.get_presentations_by_owners(current_user.id)

    render(conn, "dashboard.html", profiles: profiles, presentations: presentations, current_user: current_user, claims: claims)
    #case Repo.get_by(Profile, user_id: current_user.id) do
    #  nil ->
    #    changeset = Accounts.change_profile(%CommunityTools.Accounts.Profile{})
    #    profile = %{status: []}
    #    render(conn, "dashboard.html", profile: profile, current_user: get_session(conn, :current_user))
    #  record ->
    #    profile = Repo.get_by!(Profile, user_id: current_user.id)

  end



  def callback(%Plug.Conn{assigns: %{ueberauth_failure: fails}} = conn, _params, current_user, claims) do
    conn
    |> put_flash(:error, hd(fails.errors).message)
    |> render("signin.html", current_user: current_user, current_auths: auths(current_user), claims: claims)
  end

  def callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, _params, current_user, claims) do
    IO.inspect conn
    case UserFromAuth.get_or_insert(auth, current_user, Repo) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have been signed in")
        |> Guardian.Plug.sign_in(user, :token, perms: %{default: Guardian.Permissions.max})
        |> put_session(:current_user, user)
        |> redirect(to: "/2017/dashboard")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Could not authenticate: #{_reason}")
        |> render("signin.html", current_user: current_user, current_auths: auths(current_user), claims: claims)

    end
  end

  def credentials(conn, _, nil, _) do
    conn
    |> put_status(401)
    |> render("failed_credentials.json", error: "not_authenticated")
  end

  def credentials(conn, _params, current_user, {:ok, claims}) do
    token = Guardian.Plug.current_token(conn)
    user = %{email: current_user.email, id: current_user.id}
    render(conn, "credentials.json", %{ user: user, jwt: token }, current_user: current_user, claims: claims)
  end

  def signout(conn, _params, current_user, _claims) do
    if current_user do
      conn
      # This clears the whole session.
      # We could use sign_out(:default) to just revoke this token
      # but I prefer to clear out the session. This means that because we
      # use tokens in two locations - :default and :admin - we need to load it (see above)
      |> Guardian.Plug.sign_out
      |> put_flash(:info, "You've Been Signed Out")
      |> redirect(to: "/sign-in")
    else
      conn
      |> put_flash(:info, "You're Not Currently Signed In")
      |> redirect(to: "/sign-in")
    end
  end

  defp auths(nil), do: []
  defp auths(%User{} = user) do
    Ecto.Schema.assoc(user, :authorizations)
      |> Repo.all
      |> Enum.map(&(&1.provider))
  end



end
