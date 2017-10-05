defmodule CommunityTools.Sponsors do
  @moduledoc """
  The boundary for the Sponsors system.
  """

  import Ecto.Query, warn: false
  alias CommunityTools.Repo
  alias CommunityTools.Sponsors.Sponsor
  alias CommunityTools.Sponsors.SponsorshipOption
  alias CommunityTools.Organizations.Organization

  @doc """
  Returns the list of sponsorships.

  ## Examples

      iex> list_sponsorship_options()
      [%SponsorshipOption{}, ...]

  """
  def list_sponsorship_options do
    query = from(s in SponsorshipOption, order_by: [desc: s.price])
    Repo.all(query)

  end

  @doc """
  Gets a single sponsorship_option.

  Raises `Ecto.NoResultsError` if the SponsorshipOption does not exist.

  ## Examples

      iex> get_sponsorship_option!(123)
      %SponsorshipOption{}

      iex> get_sponsorship_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sponsorship_option!(id), do: CommunityTools.Repo.get!(SponsorshipOption, id)

  @doc """
  Creates a sponsorship_option.

  ## Examples

      iex> create_sponsorship_option(%{field: value})
      {:ok, %SponsorshipOption{}}

      iex> create_sponsorship_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sponsorship_option(attrs \\ %{}) do
    %SponsorshipOption{}
    |> SponsorshipOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sponsorship_option.

  ## Examples

      iex> update_sponsorship_option(sponsorship_option, %{field: new_value})
      {:ok, %SponsorshipOption{}}

      iex> update_sponsorship_option(sponsorship_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sponsorship_option(%SponsorshipOption{} = sponsorship_option, attrs) do
    sponsorship_option
    |> SponsorshipOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SponsorshipOption.

  ## Examples

      iex> delete_sponsorship_option(sponsorship_option)
      {:ok, %SponsorshipOption{}}

      iex> delete_sponsorship_option(sponsorship_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sponsorship_option(%SponsorshipOption{} = sponsorship_option) do
    Repo.delete(sponsorship_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sponsorship_option changes.

  ## Examples

      iex> change_sponsorship_option(sponsorship_option)
      %Ecto.Changeset{source: %SponsorshipOption{}}

  """
  def change_sponsorship_option(%SponsorshipOption{} = sponsorship_option) do
    SponsorshipOption.changeset(sponsorship_option, %{})
  end

  alias CommunityTools.Sponsors.Sponsor

  @doc """
  Returns the list of sponsors.

  ## Examples

      iex> list_sponsors()
      [%Sponsor{}, ...]

  """
  def list_sponsors do
    Repo.all(Sponsor)
  end

  @doc """
  Gets a single sponsor.

  Raises `Ecto.NoResultsError` if the Sponsor does not exist.

  ## Examples

      iex> get_sponsor!(123)
      %Sponsor{}

      iex> get_sponsor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sponsor!(id), do: Repo.get!(Sponsor, id)
  |> Repo.preload(:sponsorship_option)
  |> Repo.preload(:organization)
  @doc """
  Creates a sponsor.

  ## Examples

      iex> create_sponsor(%{field: value})
      {:ok, %Sponsor{}}

      iex> create_sponsor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sponsor(attrs \\ %{}) do
    %Sponsor{}
    |> Repo.preload(:sponsorship_option)
    |> Repo.preload(:organization)
    |> Sponsor.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:sponsorship_option, attrs.sponsorship_option)
    |> Ecto.Changeset.put_assoc(:organization, attrs.organization)
    |> Repo.insert()
  end

  @doc """
  Updates a sponsor.

  ## Examples

      iex> update_sponsor(sponsor, %{field: new_value})
      {:ok, %Sponsor{}}

      iex> update_sponsor(sponsor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sponsor(%Sponsor{} = sponsor, attrs) do
    ortd = "21"
    sponsor
    |> Repo.preload(:organization)
    |> Repo.preload(:sponsorship_option)
    |> Sponsor.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:organization_id, attrs.organization_id)
    |> Repo.update()
  end

  @doc """
  Deletes a Sponsor.

  ## Examples

      iex> delete_sponsor(sponsor)
      {:ok, %Sponsor{}}

      iex> delete_sponsor(sponsor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sponsor(%Sponsor{} = sponsor) do
    Repo.delete(sponsor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sponsor changes.

  ## Examples

      iex> change_sponsor(sponsor)
      %Ecto.Changeset{source: %Sponsor{}}

  """
  def change_sponsor(%Sponsor{} = sponsor) do
    Sponsor.changeset(sponsor, %{})
  end

  defp parse_sponsorship_option(params)  do
    unless params["sponsorship_option"] == nil do
      id = params["sponsorship_option"]
      Enum.map(id, &%{id: &1})
      Repo.all(from s in SponsorshipOption, where: s.id in ^id)
    end
  end

  defp parse_organization(params)  do
    unless params["organization"] == nil do
      id = params["organization"]
      Enum.map(id, &%{id: &1})
      Repo.all(from o in Organization, where: o.id in ^id)
    end
  end

end
