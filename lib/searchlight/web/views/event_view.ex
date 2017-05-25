defmodule Searchlight.Web.EventView do
  use Searchlight.Web, :view
  alias Searchlight.Web.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      value: event.value,
      source: event.source,
      capability: event.capability,
      current_iteration: event.current_iteration,
      event_date: event.event_date,
      unixtime: event.unixtime,
      latency: event.latency,
      passed: event.passed}
  end
end
