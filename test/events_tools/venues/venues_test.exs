defmodule CommunityTools.VenuesTest do
  use CommunityTools.DataCase

  alias CommunityTools.Venues

  describe "venues" do
    alias CommunityTools.Venues.Venue

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def venue_fixture(attrs \\ %{}) do
      {:ok, venue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Venues.create_venue()

      venue
    end

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Venues.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Venues.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      assert {:ok, %Venue{} = venue} = Venues.create_venue(@valid_attrs)
      assert venue.name == "some name"
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()
      assert {:ok, venue} = Venues.update_venue(venue, @update_attrs)
      assert %Venue{} = venue
      assert venue.name == "some updated name"
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_venue(venue, @invalid_attrs)
      assert venue == Venues.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Venues.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Venues.change_venue(venue)
    end
  end

  describe "buildings" do
    alias CommunityTools.Venues.Building

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def building_fixture(attrs \\ %{}) do
      {:ok, building} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Venues.create_building()

      building
    end

    test "list_buildings/0 returns all buildings" do
      building = building_fixture()
      assert Venues.list_buildings() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Venues.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      assert {:ok, %Building{} = building} = Venues.create_building(@valid_attrs)
      assert building.name == "some name"
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      assert {:ok, building} = Venues.update_building(building, @update_attrs)
      assert %Building{} = building
      assert building.name == "some updated name"
    end

    test "update_building/2 with invalid data returns error changeset" do
      building = building_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_building(building, @invalid_attrs)
      assert building == Venues.get_building!(building.id)
    end

    test "delete_building/1 deletes the building" do
      building = building_fixture()
      assert {:ok, %Building{}} = Venues.delete_building(building)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_building!(building.id) end
    end

    test "change_building/1 returns a building changeset" do
      building = building_fixture()
      assert %Ecto.Changeset{} = Venues.change_building(building)
    end
  end

  describe "halls" do
    alias CommunityTools.Venues.Hall

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def hall_fixture(attrs \\ %{}) do
      {:ok, hall} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Venues.create_hall()

      hall
    end

    test "list_halls/0 returns all halls" do
      hall = hall_fixture()
      assert Venues.list_halls() == [hall]
    end

    test "get_hall!/1 returns the hall with given id" do
      hall = hall_fixture()
      assert Venues.get_hall!(hall.id) == hall
    end

    test "create_hall/1 with valid data creates a hall" do
      assert {:ok, %Hall{} = hall} = Venues.create_hall(@valid_attrs)
      assert hall.name == "some name"
    end

    test "create_hall/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_hall(@invalid_attrs)
    end

    test "update_hall/2 with valid data updates the hall" do
      hall = hall_fixture()
      assert {:ok, hall} = Venues.update_hall(hall, @update_attrs)
      assert %Hall{} = hall
      assert hall.name == "some updated name"
    end

    test "update_hall/2 with invalid data returns error changeset" do
      hall = hall_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_hall(hall, @invalid_attrs)
      assert hall == Venues.get_hall!(hall.id)
    end

    test "delete_hall/1 deletes the hall" do
      hall = hall_fixture()
      assert {:ok, %Hall{}} = Venues.delete_hall(hall)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_hall!(hall.id) end
    end

    test "change_hall/1 returns a hall changeset" do
      hall = hall_fixture()
      assert %Ecto.Changeset{} = Venues.change_hall(hall)
    end
  end

  describe "hall_room_plans" do
    alias CommunityTools.Venues.Hall_Room_Plan

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def hall__room__plan_fixture(attrs \\ %{}) do
      {:ok, hall__room__plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Venues.create_hall__room__plan()

      hall__room__plan
    end

    test "list_hall_room_plans/0 returns all hall_room_plans" do
      hall__room__plan = hall__room__plan_fixture()
      assert Venues.list_hall_room_plans() == [hall__room__plan]
    end

    test "get_hall__room__plan!/1 returns the hall__room__plan with given id" do
      hall__room__plan = hall__room__plan_fixture()
      assert Venues.get_hall__room__plan!(hall__room__plan.id) == hall__room__plan
    end

    test "create_hall__room__plan/1 with valid data creates a hall__room__plan" do
      assert {:ok, %Hall_Room_Plan{} = hall__room__plan} = Venues.create_hall__room__plan(@valid_attrs)
      assert hall__room__plan.name == "some name"
    end

    test "create_hall__room__plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_hall__room__plan(@invalid_attrs)
    end

    test "update_hall__room__plan/2 with valid data updates the hall__room__plan" do
      hall__room__plan = hall__room__plan_fixture()
      assert {:ok, hall__room__plan} = Venues.update_hall__room__plan(hall__room__plan, @update_attrs)
      assert %Hall_Room_Plan{} = hall__room__plan
      assert hall__room__plan.name == "some updated name"
    end

    test "update_hall__room__plan/2 with invalid data returns error changeset" do
      hall__room__plan = hall__room__plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_hall__room__plan(hall__room__plan, @invalid_attrs)
      assert hall__room__plan == Venues.get_hall__room__plan!(hall__room__plan.id)
    end

    test "delete_hall__room__plan/1 deletes the hall__room__plan" do
      hall__room__plan = hall__room__plan_fixture()
      assert {:ok, %Hall_Room_Plan{}} = Venues.delete_hall__room__plan(hall__room__plan)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_hall__room__plan!(hall__room__plan.id) end
    end

    test "change_hall__room__plan/1 returns a hall__room__plan changeset" do
      hall__room__plan = hall__room__plan_fixture()
      assert %Ecto.Changeset{} = Venues.change_hall__room__plan(hall__room__plan)
    end
  end

  describe "rooms" do
    alias CommunityTools.Venues.Room

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Venues.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Venues.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Venues.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Venues.create_room(@valid_attrs)
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = Venues.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Venues.update_room(room, @invalid_attrs)
      assert room == Venues.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Venues.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Venues.change_room(room)
    end
  end
end
