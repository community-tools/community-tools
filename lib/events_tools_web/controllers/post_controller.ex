defmodule CommunityToolsWeb.PostController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Repo
  alias CommunityTools.Posts
  alias CommunityTools.Posts.Post


  def index(conn, _params, current_user, claims) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Posts.change_post(%CommunityTools.Posts.Post{})
    post = %{events: []}
    events_all = Repo.all(CommunityTools.Events.Event)
    render(conn, "new.html", changeset: changeset, post: post, events_all: events_all, current_user: current_user, claims: claims)
  end

  def create(conn, %{"post" => post_params}, current_user, claims) do
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        post = %{events: []}
        events_all = Repo.all(CommunityTools.Events.Event)
        render(conn, "new.html", changeset: changeset, post: post, events_all: events_all, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    #post = Posts.get_post!(id)
    post = Repo.get_by!(Post, slug: id)
    render(conn, "show.html", post: post, current_user: current_user, claims: claims)

  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    post = Posts.get_post!(id)
    |> Repo.preload(:events)
    changeset = Posts.change_post(post)
    events_all = Repo.all(CommunityTools.Events.Event)
    render(conn, "edit.html", post: post, changeset: changeset, events_all: events_all, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "post" => post_params}, current_user, claims) do
    #post = Repo.get_by!(Post, slug: id)
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated.")
        |> redirect(to: post_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        events_all = Repo.all(CommunityTools.Events.Event)
        render(conn, "edit.html", post: post, changeset: changeset, events_all: events_all, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
