defmodule CommunityTools.SponsorsTest do
  use CommunityTools.DataCase

  alias CommunityTools.Sponsors

  describe "sponsorships" do
    alias CommunityTools.Sponsors.Sponsorship

    @valid_attrs %{camps: "some camps", expo: "some expo", name: "some name", price: "120.5", program: "some program", recruiting: "some recruiting", signage: "some signage", social: "some social", stock: 42, summary: "some summary", swag: "some swag", type: "some type", website: "some website"}
    @update_attrs %{camps: "some updated camps", expo: "some updated expo", name: "some updated name", price: "456.7", program: "some updated program", recruiting: "some updated recruiting", signage: "some updated signage", social: "some updated social", stock: 43, summary: "some updated summary", swag: "some updated swag", type: "some updated type", website: "some updated website"}
    @invalid_attrs %{camps: nil, expo: nil, name: nil, price: nil, program: nil, recruiting: nil, signage: nil, social: nil, stock: nil, summary: nil, swag: nil, type: nil, website: nil}

    def sponsorship_fixture(attrs \\ %{}) do
      {:ok, sponsorship} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sponsors.create_sponsorship()

      sponsorship
    end

    test "list_sponsorships/0 returns all sponsorships" do
      sponsorship = sponsorship_fixture()
      assert Sponsors.list_sponsorships() == [sponsorship]
    end

    test "get_sponsorship!/1 returns the sponsorship with given id" do
      sponsorship = sponsorship_fixture()
      assert Sponsors.get_sponsorship!(sponsorship.id) == sponsorship
    end

    test "create_sponsorship/1 with valid data creates a sponsorship" do
      assert {:ok, %Sponsorship{} = sponsorship} = Sponsors.create_sponsorship(@valid_attrs)
      assert sponsorship.camps == "some camps"
      assert sponsorship.expo == "some expo"
      assert sponsorship.name == "some name"
      assert sponsorship.price == "120.5"
      assert sponsorship.program == "some program"
      assert sponsorship.recruiting == "some recruiting"
      assert sponsorship.signage == "some signage"
      assert sponsorship.social == "some social"
      assert sponsorship.stock == 42
      assert sponsorship.summary == "some summary"
      assert sponsorship.swag == "some swag"
      assert sponsorship.type == "some type"
      assert sponsorship.website == "some website"
    end

    test "create_sponsorship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sponsors.create_sponsorship(@invalid_attrs)
    end

    test "update_sponsorship/2 with valid data updates the sponsorship" do
      sponsorship = sponsorship_fixture()
      assert {:ok, sponsorship} = Sponsors.update_sponsorship(sponsorship, @update_attrs)
      assert %Sponsorship{} = sponsorship
      assert sponsorship.camps == "some updated camps"
      assert sponsorship.expo == "some updated expo"
      assert sponsorship.name == "some updated name"
      assert sponsorship.price == "456.7"
      assert sponsorship.program == "some updated program"
      assert sponsorship.recruiting == "some updated recruiting"
      assert sponsorship.signage == "some updated signage"
      assert sponsorship.social == "some updated social"
      assert sponsorship.stock == 43
      assert sponsorship.summary == "some updated summary"
      assert sponsorship.swag == "some updated swag"
      assert sponsorship.type == "some updated type"
      assert sponsorship.website == "some updated website"
    end

    test "update_sponsorship/2 with invalid data returns error changeset" do
      sponsorship = sponsorship_fixture()
      assert {:error, %Ecto.Changeset{}} = Sponsors.update_sponsorship(sponsorship, @invalid_attrs)
      assert sponsorship == Sponsors.get_sponsorship!(sponsorship.id)
    end

    test "delete_sponsorship/1 deletes the sponsorship" do
      sponsorship = sponsorship_fixture()
      assert {:ok, %Sponsorship{}} = Sponsors.delete_sponsorship(sponsorship)
      assert_raise Ecto.NoResultsError, fn -> Sponsors.get_sponsorship!(sponsorship.id) end
    end

    test "change_sponsorship/1 returns a sponsorship changeset" do
      sponsorship = sponsorship_fixture()
      assert %Ecto.Changeset{} = Sponsors.change_sponsorship(sponsorship)
    end
  end

  describe "sponsors" do
    alias CommunityTools.Sponsors.Sponsor

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def sponsor_fixture(attrs \\ %{}) do
      {:ok, sponsor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sponsors.create_sponsor()

      sponsor
    end

    test "list_sponsors/0 returns all sponsors" do
      sponsor = sponsor_fixture()
      assert Sponsors.list_sponsors() == [sponsor]
    end

    test "get_sponsor!/1 returns the sponsor with given id" do
      sponsor = sponsor_fixture()
      assert Sponsors.get_sponsor!(sponsor.id) == sponsor
    end

    test "create_sponsor/1 with valid data creates a sponsor" do
      assert {:ok, %Sponsor{} = sponsor} = Sponsors.create_sponsor(@valid_attrs)
      assert sponsor.name == "some name"
    end

    test "create_sponsor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sponsors.create_sponsor(@invalid_attrs)
    end

    test "update_sponsor/2 with valid data updates the sponsor" do
      sponsor = sponsor_fixture()
      assert {:ok, sponsor} = Sponsors.update_sponsor(sponsor, @update_attrs)
      assert %Sponsor{} = sponsor
      assert sponsor.name == "some updated name"
    end

    test "update_sponsor/2 with invalid data returns error changeset" do
      sponsor = sponsor_fixture()
      assert {:error, %Ecto.Changeset{}} = Sponsors.update_sponsor(sponsor, @invalid_attrs)
      assert sponsor == Sponsors.get_sponsor!(sponsor.id)
    end

    test "delete_sponsor/1 deletes the sponsor" do
      sponsor = sponsor_fixture()
      assert {:ok, %Sponsor{}} = Sponsors.delete_sponsor(sponsor)
      assert_raise Ecto.NoResultsError, fn -> Sponsors.get_sponsor!(sponsor.id) end
    end

    test "change_sponsor/1 returns a sponsor changeset" do
      sponsor = sponsor_fixture()
      assert %Ecto.Changeset{} = Sponsors.change_sponsor(sponsor)
    end
  end
end
