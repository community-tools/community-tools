defmodule CommunityTools.TagsTest do
  use CommunityTools.DataCase

  alias CommunityTools.Tags

  describe "tags" do
    alias CommunityTools.Tags.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tags.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Tags.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Tags.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Tags.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Tags.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_tag(tag, @invalid_attrs)
      assert tag == Tags.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Tags.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_tag(tag)
    end
  end

  describe "technologies" do
    alias CommunityTools.Tags.Technology

    @valid_attrs %{description: "some description", logo: "some logo", name: "some name"}
    @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name"}
    @invalid_attrs %{description: nil, logo: nil, name: nil}

    def technology_fixture(attrs \\ %{}) do
      {:ok, technology} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tags.create_technology()

      technology
    end

    test "list_technologies/0 returns all technologies" do
      technology = technology_fixture()
      assert Tags.list_technologies() == [technology]
    end

    test "get_technology!/1 returns the technology with given id" do
      technology = technology_fixture()
      assert Tags.get_technology!(technology.id) == technology
    end

    test "create_technology/1 with valid data creates a technology" do
      assert {:ok, %Technology{} = technology} = Tags.create_technology(@valid_attrs)
      assert technology.description == "some description"
      assert technology.logo == "some logo"
      assert technology.name == "some name"
    end

    test "create_technology/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_technology(@invalid_attrs)
    end

    test "update_technology/2 with valid data updates the technology" do
      technology = technology_fixture()
      assert {:ok, technology} = Tags.update_technology(technology, @update_attrs)
      assert %Technology{} = technology
      assert technology.description == "some updated description"
      assert technology.logo == "some updated logo"
      assert technology.name == "some updated name"
    end

    test "update_technology/2 with invalid data returns error changeset" do
      technology = technology_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_technology(technology, @invalid_attrs)
      assert technology == Tags.get_technology!(technology.id)
    end

    test "delete_technology/1 deletes the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{}} = Tags.delete_technology(technology)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_technology!(technology.id) end
    end

    test "change_technology/1 returns a technology changeset" do
      technology = technology_fixture()
      assert %Ecto.Changeset{} = Tags.change_technology(technology)
    end
  end
end
