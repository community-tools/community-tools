defmodule CommunityTools.Presentations do
  @moduledoc """
  The boundary for the Presentations system.
  """

  import Ecto.Query, warn: false
  alias CommunityTools.Repo
  alias CommunityTools.Helpers
  alias CommunityTools.Presentations.Presentation

  @doc """
  Returns the list of presentations.

  ## Examples

      iex> list_presentations()
      [%Presentation{}, ...]

  """
  def list_presentations do
    Repo.all(Presentation)
    |> Repo.preload(:presenters)
    |> Repo.preload(:events)
  end

  @doc """
  Gets a single presentation.

  Raises `Ecto.NoResultsError` if the Presentation does not exist.

  ## Examples

      iex> get_presentation!(123)
      %Presentation{}

      iex> get_presentation!(456)
      ** (Ecto.NoResultsError)

  """
  #def get_presentation!(id), do: Repo.get!(Presentation, id)
  def get_presentation!(id), do: Repo.get_by!(Presentation, slug: id)
  |> Repo.preload(:presenters)
  |> Repo.preload(:events)
  |> Repo.preload(:owners)


  def get_presentations_by_owners(id) do
#  query = from(p in Presentation,
    #join: po in "presentations_owners", on: po.presentation_id == p.id,
    #query = from(p in Presentation, where: not(is_nil(p.id)))
    query = from(p in Presentation,
    join: po in "presentations_owners", on: po.presentation_id == p.id,
    where: po.user_id == ^id)
    Repo.all(query)
    |> Repo.preload(:presenters)

  end



  @doc """
  Creates a presentation.

  ## Examples

      iex> create_presentation(%{field: value})
      {:ok, %Presentation{}}

      iex> create_presentation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_presentation(attrs \\ %{}, owner) do
    %Presentation{}
    |> Repo.preload(:presenters)
    |> Repo.preload(:events)
    |> Repo.preload(:owners)
    |> Presentation.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:presenters, Helpers.parse_presenters(attrs))
    |> Ecto.Changeset.put_assoc(:events, Helpers.parse_events(attrs))
    |> Ecto.Changeset.put_assoc(:owners, [owner])
    |> Repo.insert()
    #IO.inspect owners
  end

  @doc """
  Updates a presentation.

  ## Examples

      iex> update_presentation(presentation, %{field: new_value})
      {:ok, %Presentation{}}

      iex> update_presentation(presentation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_presentation(%Presentation{} = presentation, attrs) do
    presentation
    |> Repo.preload(:presenters)
    |> Repo.preload(:events)
    |> Presentation.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:presenters, Helpers.parse_presenters(attrs))
    |> Ecto.Changeset.put_assoc(:events, Helpers.parse_events(attrs))
    |> Repo.update()
  end

  @doc """
  Deletes a Presentation.

  ## Examples

      iex> delete_presentation(presentation)
      {:ok, %Presentation{}}

      iex> delete_presentation(presentation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_presentation(%Presentation{} = presentation) do
    Repo.delete(presentation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking presentation changes.

  ## Examples

      iex> change_presentation(presentation)
      %Ecto.Changeset{source: %Presentation{}}

  """
  def change_presentation(%Presentation{} = presentation) do
    Presentation.changeset(presentation, %{})
  end

end
