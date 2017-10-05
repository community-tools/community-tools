defmodule CommunityTools.Accounts do

    import Ecto.Query, warn: false
    alias CommunityTools.Repo
    alias CommunityTools.Helpers
    alias CommunityTools.Accounts.Roles
    alias CommunityTools.Accounts.User
    alias CommunityTools.Accounts.Profile
    alias CommunityTools.Repo



  #USERS

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    |> Repo.preload(:roles)
    |> Repo.preload(:status)

  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  |> Repo.preload(:roles)
  |> Repo.preload(:status)



  def get_profiles_by_user(id) do
#  query = from(p in Presentation,
    #join: po in "presentations_owners", on: po.presentation_id == p.id,
    #query = from(p in Presentation, where: not(is_nil(p.id)))
    query = from(p in Profile,
    where: p.user_id == ^id)
    Repo.all(query)
  end






  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}, user) do
    %User{}
    |> Repo.preload(:roles)
    |> Repo.preload(:status)
    |> User.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:roles, Helpers.parse_roles(attrs))
    |> Ecto.Changeset.put_assoc(:status, Helpers.parse_status(attrs))
    |> Ecto.Changeset.put_change(:user_id, [user])
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> Repo.preload(:roles)
    |> Repo.preload(:status)
    |> User.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:roles, Helpers.parse_roles(attrs))
    |> Ecto.Changeset.put_assoc(:status, Helpers.parse_status(attrs))
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end












  #ROLES

  @moduledoc """
  The Accounts context.
  """



  @doc """
  Returns the list of role.

  ## Examples

      iex> list_role()
      [%Roles{}, ...]

  """
  def list_roles do
    Repo.all(Roles)
  end

  @doc """
  Gets a single roles.

  Raises `Ecto.NoResultsError` if the Roles does not exist.

  ## Examples

      iex> get_roles!(123)
      %Roles{}

      iex> get_roles!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roles!(id), do: Repo.get!(Roles, slug: id)

  @doc """
  Creates a roles.

  ## Examples

      iex> create_roles(%{field: value})
      {:ok, %Roles{}}

      iex> create_roles(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roles(attrs \\ %{}) do
    %Roles{}
    |> Roles.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a roles.

  ## Examples

      iex> update_roles(roles, %{field: new_value})
      {:ok, %Roles{}}

      iex> update_roles(roles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roles(%Roles{} = roles, attrs) do
    roles
    |> Roles.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Roles.

  ## Examples

      iex> delete_roles(roles)
      {:ok, %Roles{}}

      iex> delete_roles(roles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roles(%Roles{} = roles) do
    Repo.delete(roles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roles changes.

  ## Examples

      iex> change_roles(roles)
      %Ecto.Changeset{source: %Roles{}}

  """
  def change_roles(%Roles{} = roles) do
    Roles.changeset(roles, %{})
  end

  def get_roles!(id), do: Repo.get!(Roles, slug: id)












  #PROFILES
  @doc """
  Returns the list of profiles.

  ## Examples

      iex> list_profiles()
      [%Profile{}, ...]

  """
  def list_profiles do
    query = from(p in Profile, order_by: p.name_last)
    Repo.all(query)
    |> Repo.preload(:status)
  end

  def all_profiles do
    query = from(p in Profile,
    where: p.id != 1,
    order_by: p.name_first)
    Repo.all(query)
  end

  def list_team do
    query = from(p in Profile,
      #join: a in "albums", on: t.album_id == a.id,
      join: ps in "profiles_status", on: ps.profile_id == p.id,
      join: s in "status", on: ps.status_id == s.id,
      where: s.title == ^"Published",
      order_by: p.name_first)
    Repo.all(query)
    |> Repo.preload(:status)
  end


  @doc """
  Gets a single profile.

  Raises `Ecto.NoResultsError` if the Profile does not exist.

  ## Examples

      iex> get_profile!(123)
      %Profile{}

      iex> get_profile!(456)
      ** (Ecto.NoResultsError)

  """
  #def get_profile!(id), do: Repo.get!(Profile, id)
  def get_profile!(id), do: Repo.get_by!(Profile, slug: id)
  |> Repo.preload(:presentations)
  |> Repo.preload(:status)

  @doc """
  Creates a profile.

  ## Examples

      iex> create_profile(%{field: value})
      {:ok, %Profile{}}

      iex> create_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profile(attrs \\ %{}, current_user) do
    %Profile{}
    |> Repo.preload(:status)
    |> Profile.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, current_user.id)
    |> Ecto.Changeset.put_assoc(:status, Helpers.parse_status(attrs))
    |> Repo.insert()
  end

  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile(%Profile{} = profile, attrs, current_user) do
    profile
    |> Repo.preload(:status)
    |> Profile.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, current_user.id)
    |> Ecto.Changeset.put_assoc(:status, Helpers.parse_status(attrs))
    |> Repo.update()
  end

  @doc """
  Deletes a Profile.

  ## Examples

      iex> delete_profile(profile)
      {:ok, %Profile{}}

      iex> delete_profile(profile)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profile(%Profile{} = profile) do
    Repo.delete(profile)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile changes.

  ## Examples

      iex> change_profile(profile)
      %Ecto.Changeset{source: %Profile{}}

  """
  def change_profile(%Profile{} = profile) do
    Profile.changeset(profile, %{})
  end







  defp parse_roles(params)  do
    unless params["roles"] == nil do
      id = params["roles"]
      Enum.map(id, &%{id: &1})
      Repo.all(from r in CommunityTools.Accounts.Roles, where: r.id in ^id)
    end
  end

  defp parse_status(params)  do
    if params["status"] == nil do
      Repo.all(from s in CommunityTools.Status.Status, where: s.id == 4)
    else
      id = params["status"]
      Enum.map(id, &%{id: &1})
      Repo.all(from s in CommunityTools.Status.Status, where: s.id in ^id)
    end
  end








end
