defmodule CommunityToolsWeb.Hall_Room_PlanController do
  use CommunityToolsWeb, :controller

  alias CommunityTools.Venues

  def index(conn, _params, current_user, claims) do
    hall_room_plans = Venues.list_hall_room_plans()
    render(conn, "index.html", hall_room_plans: hall_room_plans, current_user: current_user, claims: claims)
  end

  def new(conn, _params, current_user, claims) do
    changeset = Venues.change_hall__room__plan(%CommunityTools.Venues.Hall_Room_Plan{})
    render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
  end

  def create(conn, %{"hall__room__plan" => hall__room__plan_params}, current_user, claims) do
    case Venues.create_hall__room__plan(hall__room__plan_params) do
      {:ok, hall__room__plan} ->
        conn
        |> put_flash(:info, "Hall  room  plan created successfully.")
        |> redirect(to: hall__room__plan_path(conn, :show, hall__room__plan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def show(conn, %{"id" => id}, current_user, claims) do
    hall__room__plan = Venues.get_hall__room__plan!(id)
    render(conn, "show.html", hall__room__plan: hall__room__plan, current_user: current_user, claims: claims)
  end

  def edit(conn, %{"id" => id}, current_user, claims) do
    hall__room__plan = Venues.get_hall__room__plan!(id)
    changeset = Venues.change_hall__room__plan(hall__room__plan)
    render(conn, "edit.html", hall__room__plan: hall__room__plan, changeset: changeset, current_user: current_user, claims: claims)
  end

  def update(conn, %{"id" => id, "hall__room__plan" => hall__room__plan_params}, current_user, claims) do
    hall__room__plan = Venues.get_hall__room__plan!(id)

    case Venues.update_hall__room__plan(hall__room__plan, hall__room__plan_params) do
      {:ok, hall__room__plan} ->
        conn
        |> put_flash(:info, "Hall  room  plan updated successfully.")
        |> redirect(to: hall__room__plan_path(conn, :show, hall__room__plan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hall__room__plan: hall__room__plan, changeset: changeset, current_user: current_user, claims: claims)
    end
  end

  def delete(conn, %{"id" => id}, _current_user, _claims) do
    hall__room__plan = Venues.get_hall__room__plan!(id)
    {:ok, _hall__room__plan} = Venues.delete_hall__room__plan(hall__room__plan)

    conn
    |> put_flash(:info, "Hall  room  plan deleted successfully.")
    |> redirect(to: hall__room__plan_path(conn, :index))
  end
end
