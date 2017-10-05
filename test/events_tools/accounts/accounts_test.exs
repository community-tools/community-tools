defmodule CommunityTools.AccountsTest do
  use CommunityTools.DataCase

  alias CommunityTools.Accounts




  describe "users" do
    alias CommunityTools.Accounts.User

    @valid_attrs %{email: "some email", password: "some password", username: "some username"}
    @update_attrs %{email: "some updated email", password: "some updated password", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end




  describe "role" do
    alias CommunityTools.Accounts.Roles

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def roles_fixture(attrs \\ %{}) do
      {:ok, roles} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_roles()

      roles
    end

    test "list_role/0 returns all role" do
      roles = roles_fixture()
      assert Accounts.list_role() == [roles]
    end

    test "get_roles!/1 returns the roles with given id" do
      roles = roles_fixture()
      assert Accounts.get_roles!(roles.id) == roles
    end

    test "create_roles/1 with valid data creates a roles" do
      assert {:ok, %Roles{} = roles} = Accounts.create_roles(@valid_attrs)
      assert roles.description == "some description"
      assert roles.name == "some name"
    end

    test "create_roles/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_roles(@invalid_attrs)
    end

    test "update_roles/2 with valid data updates the roles" do
      roles = roles_fixture()
      assert {:ok, roles} = Accounts.update_roles(roles, @update_attrs)
      assert %Roles{} = roles
      assert roles.description == "some updated description"
      assert roles.name == "some updated name"
    end

    test "update_roles/2 with invalid data returns error changeset" do
      roles = roles_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_roles(roles, @invalid_attrs)
      assert roles == Accounts.get_roles!(roles.id)
    end

    test "delete_roles/1 deletes the roles" do
      roles = roles_fixture()
      assert {:ok, %Roles{}} = Accounts.delete_roles(roles)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_roles!(roles.id) end
    end

    test "change_roles/1 returns a roles changeset" do
      roles = roles_fixture()
      assert %Ecto.Changeset{} = Accounts.change_roles(roles)
    end
  end





  describe "profiles" do
    alias CommunityTools.Accounts.Profile

    @valid_attrs %{avatar: "some avatar", bio: "some bio", country: "some country", facebook: "some facebook", github: "some github", linkedin: "some linkedin", name: "some name", organization: "some organization", role: "some role", state: "some state", twitter: "some twitter", website: "some website"}
    @update_attrs %{avatar: "some updated avatar", bio: "some updated bio", country: "some updated country", facebook: "some updated facebook", github: "some updated github", linkedin: "some updated linkedin", name: "some updated name", organization: "some updated organization", role: "some updated role", state: "some updated state", twitter: "some updated twitter", website: "some updated website"}
    @invalid_attrs %{avatar: nil, bio: nil, country: nil, facebook: nil, github: nil, linkedin: nil, name: nil, organization: nil, role: nil, state: nil, twitter: nil, website: nil}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Accounts.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Accounts.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Accounts.create_profile(@valid_attrs)
      assert profile.avatar == "some avatar"
      assert profile.bio == "some bio"
      assert profile.country == "some country"
      assert profile.facebook == "some facebook"
      assert profile.github == "some github"
      assert profile.linkedin == "some linkedin"
      assert profile.name == "some name"
      assert profile.organization == "some organization"
      assert profile.role == "some role"
      assert profile.state == "some state"
      assert profile.twitter == "some twitter"
      assert profile.website == "some website"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, profile} = Accounts.update_profile(profile, @update_attrs)
      assert %Profile{} = profile
      assert profile.avatar == "some updated avatar"
      assert profile.bio == "some updated bio"
      assert profile.country == "some updated country"
      assert profile.facebook == "some updated facebook"
      assert profile.github == "some updated github"
      assert profile.linkedin == "some updated linkedin"
      assert profile.name == "some updated name"
      assert profile.organization == "some updated organization"
      assert profile.role == "some updated role"
      assert profile.state == "some updated state"
      assert profile.twitter == "some updated twitter"
      assert profile.website == "some updated website"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_profile(profile, @invalid_attrs)
      assert profile == Accounts.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Accounts.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Accounts.change_profile(profile)
    end
  end




end
