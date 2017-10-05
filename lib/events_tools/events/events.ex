defmodule CommunityTools.Events do
  @moduledoc """
  The boundary for the Posts system.
  """

  import Ecto.Query, warn: true
  alias CommunityTools.Repo
  alias CommunityTools.Helpers
  alias CommunityTools.Events.Event

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_events do
    query = from(e in Event,
    where: e.id != 1,
    order_by: e.name)
    Repo.all(query)
  end

  def all_events do
    query = from(e in Event,
    where: e.id != 1,
    order_by: e.name)
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
  #def get_event!(id), do: Repo.get!(Event, id)
  def get_event!(id), do: Repo.get_by!(Event, slug: id)
  |> Repo.preload(:organizers)
  |> Repo.preload(:presentations)
  |> Repo.preload(presentations: :presenters)
  |> Repo.preload(:posts)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Repo.preload(:organizers)
    |> Event.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:organizers, Helpers.parse_organizers(attrs))
    |> PaperTrail.insert()
    #|> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Repo.preload(:organizers)
    |> Event.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:organizers, Helpers.parse_organizers(attrs))
    |> Repo.update()
    #|> PaperTrail.update()

    #IO.inspect attrs
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    #Repo.delete(event)
    PaperTrail.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
    #|> put_assoc(:users, [])
  end


end
