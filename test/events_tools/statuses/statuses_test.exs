defmodule CommunityTools.StatusTest do
  use CommunityTools.DataCase

  alias CommunityTools.Status

  describe "status" do
    alias CommunityTools.Status.Status

    @valid_attrs %{summary: "some summary", title: "some title"}
    @update_attrs %{summary: "some updated summary", title: "some updated title"}
    @invalid_attrs %{summary: nil, title: nil}

    def status_fixture(attrs \\ %{}) do
      {:ok, status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Status.create_status()

      status
    end

    test "list_status/0 returns all status" do
      status = status_fixture()
      assert Status.list_status() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Status.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      assert {:ok, %Status{} = status} = Status.create_status(@valid_attrs)
      assert status.summary == "some summary"
      assert status.title == "some title"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Status.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, status} = Status.update_status(status, @update_attrs)
      assert %Status{} = status
      assert status.summary == "some updated summary"
      assert status.title == "some updated title"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Status.update_status(status, @invalid_attrs)
      assert status == Status.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Status.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Status.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Status.change_status(status)
    end
  end
end
