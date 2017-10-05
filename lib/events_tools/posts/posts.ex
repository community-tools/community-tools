defmodule CommunityTools.Posts do
  @moduledoc """
  The boundary for the Posts system.
  """

  import Ecto.Query, warn: false
  alias CommunityTools.Repo

  alias CommunityTools.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    query = from(p in Post, order_by: [desc: p.date])
    Repo.all(query)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  #def get_post!(id), do: Repo.get!(Post, id)
  def get_post!(id), do: Repo.get_by!(Post, slug: id)
  |> Repo.preload(:events)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Repo.preload(:events)
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:events, parse_events(attrs))
    #|> Repo.insert()
    |> PaperTrail.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Repo.preload(:events)
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:events, parse_events(attrs))
    |> Repo.update()
    #|> PaperTrail.update()


  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    #Repo.delete(post)
    PaperTrail.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  defp parse_events(params)  do
    unless params["events"] == nil do
      id = params["events"]
      Enum.map(id, &%{id: &1})
      Repo.all(from e in CommunityTools.Events.Event, where: e.id in ^id)
    end
  end

end
