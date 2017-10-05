defmodule CommunityTools.Venues do
  @moduledoc """
  The boundary for the Venues system.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset, warn: false

  alias CommunityTools.Repo

  alias CommunityTools.Venues.Venue
  alias CommunityTools.Venues.Building

  @doc """
  Returns the list of venues.

  ## Examples

      iex> list_venues()
      [%Venue{}, ...]

  """
  def list_venues do
    Repo.all(Venue)

  end

  @doc """
  Gets a single venue.

  Raises `Ecto.NoResultsError` if the Venue does not exist.

  ## Examples

      iex> get_venue!(123)
      %Venue{}

      iex> get_venue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_venue!(id), do: Repo.get!(Venue, id)

  @doc """
  Creates a venue.

  ## Examples

      iex> create_venue(%{field: value})
      {:ok, %Venue{}}

      iex> create_venue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_venue(attrs \\ %{}) do
    %Venue{}
    |> Venue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a venue.

  ## Examples

      iex> update_venue(venue, %{field: new_value})
      {:ok, %Venue{}}

      iex> update_venue(venue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_venue(%Venue{} = venue, attrs) do
    venue
    |> Venue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Venue.

  ## Examples

      iex> delete_venue(venue)
      {:ok, %Venue{}}

      iex> delete_venue(venue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_venue(%Venue{} = venue) do
    Repo.delete(venue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking venue changes.

  ## Examples

      iex> change_venue(venue)
      %Ecto.Changeset{source: %Venue{}}

  """
  def change_venue(%Venue{} = venue) do
    Venue.changeset(venue, %{})
  end

  alias CommunityTools.Venues.Building

  @doc """
  Returns the list of buildings.

  ## Examples

      iex> list_buildings()
      [%Building{}, ...]

  """
  def list_buildings do
    Repo.all(Building)
    |> Repo.preload(:venue)

  end

  @doc """
  Gets a single building.

  Raises `Ecto.NoResultsError` if the Building does not exist.

  ## Examples

      iex> get_building!(123)
      %Building{}

      iex> get_building!(456)
      ** (Ecto.NoResultsError)

  """
  def get_building!(id), do: Repo.get!(Building, id)
  |> Repo.preload(:venue)

  @doc """
  Creates a building.

  ## Examples

      iex> create_building(%{field: value})
      {:ok, %Building{}}

      iex> create_building(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_building(attrs \\ %{}) do
    %Building{}
    |> Building.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a building.

  ## Examples

      iex> update_building(building, %{field: new_value})
      {:ok, %Building{}}

      iex> updaute_building(building, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_building(%Building{} = building, attrs) do
    building
    |> Building.changeset(attrs)
    |> Ecto.build_assoc(:venue)
    |> Repo.update()
  end

  @doc """
  Deletes a Building.

  ## Examples

      iex> delete_building(building)
      {:ok, %Building{}}

      iex> delete_building(building)
      {:error, %Ecto.Changeset{}}

  """
  def delete_building(%Building{} = building) do
    Repo.delete(building)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking building changes.

  ## Examples

      iex> change_building(building)
      %Ecto.Changeset{source: %Building{}}

  """
  def change_building(%Building{} = building) do
    Building.changeset(building, %{})
    |> Repo.preload(:venue)
  end

  alias CommunityTools.Venues.Hall

  @doc """
  Returns the list of halls.

  ## Examples

      iex> list_halls()
      [%Hall{}, ...]

  """
  def list_halls do
    Repo.all(from Hall, order_by: [asc: :name] )
    |> Repo.preload(:building)

  end

  @doc """
  Gets a single hall.

  Raises `Ecto.NoResultsError` if the Hall does not exist.

  ## Examples

      iex> get_hall!(123)
      %Hall{}

      iex> get_hall!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hall!(id), do: Repo.get!(Hall, id)
  |> Repo.preload(:building)
  @doc """
  Creates a hall.

  ## Examples

      iex> create_hall(%{field: value})
      {:ok, %Hall{}}

      iex> create_hall(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hall(attrs \\ %{}) do
    %Hall{}
    |> Hall.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hall.

  ## Examples

      iex> update_hall(hall, %{field: new_value})
      {:ok, %Hall{}}

      iex> update_hall(hall, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hall(%Hall{} = hall, attrs) do
    hall
    |> Hall.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hall.

  ## Examples

      iex> delete_hall(hall)
      {:ok, %Hall{}}

      iex> delete_hall(hall)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hall(%Hall{} = hall) do
    Repo.delete(hall)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hall changes.

  ## Examples

      iex> change_hall(hall)
      %Ecto.Changeset{source: %Hall{}}

  """
  def change_hall(%Hall{} = hall) do
    Hall.changeset(hall, %{})
  end

  alias CommunityTools.Venues.Hall_Room_Plan

  @doc """
  Returns the list of hall_room_plans.

  ## Examples

      iex> list_hall_room_plans()
      [%Hall_Room_Plan{}, ...]

  """
  def list_hall_room_plans do
    Repo.all(from Hall_Room_Plan, order_by: [asc: :name] )
    |> Repo.preload(:hall)

  end

  @doc """
  Gets a single hall__room__plan.

  Raises `Ecto.NoResultsError` if the Hall  room  plan does not exist.

  ## Examples

      iex> get_hall__room__plan!(123)
      %Hall_Room_Plan{}

      iex> get_hall__room__plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hall__room__plan!(id), do: Repo.get!(Hall_Room_Plan, id)
  |> Repo.preload(:hall)
  @doc """
  Creates a hall__room__plan.

  ## Examples

      iex> create_hall__room__plan(%{field: value})
      {:ok, %Hall_Room_Plan{}}

      iex> create_hall__room__plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hall__room__plan(attrs \\ %{}) do
    %Hall_Room_Plan{}
    |> Hall_Room_Plan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hall__room__plan.

  ## Examples

      iex> update_hall__room__plan(hall__room__plan, %{field: new_value})
      {:ok, %Hall_Room_Plan{}}

      iex> update_hall__room__plan(hall__room__plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hall__room__plan(%Hall_Room_Plan{} = hall__room__plan, attrs) do
    hall__room__plan
    |> Hall_Room_Plan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hall_Room_Plan.

  ## Examples

      iex> delete_hall__room__plan(hall__room__plan)
      {:ok, %Hall_Room_Plan{}}

      iex> delete_hall__room__plan(hall__room__plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hall__room__plan(%Hall_Room_Plan{} = hall__room__plan) do
    Repo.delete(hall__room__plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hall__room__plan changes.

  ## Examples

      iex> change_hall__room__plan(hall__room__plan)
      %Ecto.Changeset{source: %Hall_Room_Plan{}}

  """
  def change_hall__room__plan(%Hall_Room_Plan{} = hall__room__plan) do
    Hall_Room_Plan.changeset(hall__room__plan, %{})
  end

  alias CommunityTools.Venues.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
