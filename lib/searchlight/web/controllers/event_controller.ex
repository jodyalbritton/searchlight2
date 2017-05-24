defmodule Searchlight.Web.EventController do
  use Searchlight.Web, :controller

  alias Searchlight.EventManager
  alias Searchlight.EventManager.Event

  action_fallback Searchlight.Web.FallbackController

  def index(conn, _params) do
    events = EventManager.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- EventManager.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = EventManager.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = EventManager.get_event!(id)

    with {:ok, %Event{} = event} <- EventManager.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = EventManager.get_event!(id)
    with {:ok, %Event{}} <- EventManager.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
