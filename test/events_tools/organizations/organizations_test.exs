defmodule CommunityTools.OrganizationsTest do
  use CommunityTools.DataCase

  alias CommunityTools.Organizations

  describe "organizations" do
    alias CommunityTools.Organizations.Organization

    @valid_attrs %{email: "some email", facebook: "some facebook", github: "some github", linkedin: "some linkedin", name: "some name", phone: "some phone", summary: "some summary", twitter: "some twitter", type: "some type", website: "some website"}
    @update_attrs %{email: "some updated email", facebook: "some updated facebook", github: "some updated github", linkedin: "some updated linkedin", name: "some updated name", phone: "some updated phone", summary: "some updated summary", twitter: "some updated twitter", type: "some updated type", website: "some updated website"}
    @invalid_attrs %{email: nil, facebook: nil, github: nil, linkedin: nil, name: nil, phone: nil, summary: nil, twitter: nil, type: nil, website: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Organizations.create_organization(@valid_attrs)
      assert organization.email == "some email"
      assert organization.facebook == "some facebook"
      assert organization.github == "some github"
      assert organization.linkedin == "some linkedin"
      assert organization.name == "some name"
      assert organization.phone == "some phone"
      assert organization.summary == "some summary"
      assert organization.twitter == "some twitter"
      assert organization.type == "some type"
      assert organization.website == "some website"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Organizations.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
      assert organization.email == "some updated email"
      assert organization.facebook == "some updated facebook"
      assert organization.github == "some updated github"
      assert organization.linkedin == "some updated linkedin"
      assert organization.name == "some updated name"
      assert organization.phone == "some updated phone"
      assert organization.summary == "some updated summary"
      assert organization.twitter == "some updated twitter"
      assert organization.type == "some updated type"
      assert organization.website == "some updated website"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update_organization(organization, @invalid_attrs)
      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
