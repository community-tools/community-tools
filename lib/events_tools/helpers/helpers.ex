defmodule CommunityTools.Helpers do
  import Ecto.Query, warn: false
  alias CommunityTools.Repo

  def parse_events(params)  do
    if params["events"] == nil do
      Repo.all(from e in CommunityTools.Events.Event, where: e.id == 1)
    else
      id = params["events"]
      Enum.map(id, &%{id: &1})
      Repo.all(from e in CommunityTools.Events.Event, where: e.id in ^id)
    end
  end

  def parse_organizers(params)  do
    unless params["organizers"] == nil do
      id = params["organizers"]
      Enum.map(id, &%{id: &1})
      Repo.all(from p in CommunityTools.Accounts.Profile, where: p.id in ^id)
    end
  end

  def parse_roles(params)  do
    if params["roles"] == nil do
      Repo.all(from r in CommunityTools.Accounts.Roles, where: r.id == 7)
    else
      id = params["roles"]
      Enum.map(id, &%{id: &1})
      Repo.all(from r in CommunityTools.Accounts.Roles, where: r.id in ^id)
    end
  end

  def parse_presenters(params)  do
    if params["presenters"] == nil do
      Repo.all(from p in CommunityTools.Accounts.Profile, where: p.id == 1)
    else
      id = params["presenters"]
      Enum.map(id, &%{id: &1})
      Repo.all(from p in CommunityTools.Accounts.Profile, where: p.id in ^id)
    end
  end

  def parse_status(params)  do
    if params["status"] == nil do
      Repo.all(from s in CommunityTools.Status.Status, where: s.id == 4)
    else
      id = params["status"]
      Enum.map(id, &%{id: &1})
      Repo.all(from s in CommunityTools.Status.Status, where: s.id in ^id)
    end
  end

end
