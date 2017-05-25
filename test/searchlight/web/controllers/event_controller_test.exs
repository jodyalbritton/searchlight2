defmodule Searchlight.Web.EventControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.EventManager
  alias Searchlight.EventManager.Event

<<<<<<< HEAD
  @create_attrs %{capability: "some capability", current_iteration: 42, event_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, latency: "some latency", passed: true, source: "some source", unixtime: 42, value: "some value"}
  @update_attrs %{capability: "some updated capability", current_iteration: 43, event_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, latency: "some updated latency", passed: false, source: "some updated source", unixtime: 43, value: "some updated value"}
  @invalid_attrs %{capability: nil, current_iteration: nil, event_date: nil, latency: nil, passed: nil, source: nil, unixtime: nil, value: nil}
=======
  @create_attrs %{capability: "some capability", current_iteration: 42, event_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, source: "some source", unix_time: 42, value: "some value"}
  @update_attrs %{capability: "some updated capability", current_iteration: 43, event_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, source: "some updated source", unix_time: 43, value: "some updated value"}
  @invalid_attrs %{capability: nil, current_iteration: nil, event_date: nil, source: nil, unix_time: nil, value: nil}
>>>>>>> 994f7de165890167b2179a24826febe88ada0fad

  def fixture(:event) do
    {:ok, event} = EventManager.create_event(@create_attrs)
    event
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates event and renders event when data is valid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, event_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "capability" => "some capability",
      "current_iteration" => 42,
      "event_date" => %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"},
<<<<<<< HEAD
      "latency" => "some latency",
      "passed" => true,
      "source" => "some source",
      "unixtime" => 42,
=======
      "source" => "some source",
      "unix_time" => 42,
>>>>>>> 994f7de165890167b2179a24826febe88ada0fad
      "value" => "some value"}
  end

  test "does not create event and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen event and renders event when data is valid", %{conn: conn} do
    %Event{id: id} = event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, event_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "capability" => "some updated capability",
      "current_iteration" => 43,
      "event_date" => %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"},
<<<<<<< HEAD
      "latency" => "some updated latency",
      "passed" => false,
      "source" => "some updated source",
      "unixtime" => 43,
=======
      "source" => "some updated source",
      "unix_time" => 43,
>>>>>>> 994f7de165890167b2179a24826febe88ada0fad
      "value" => "some updated value"}
  end

  test "does not update chosen event and renders errors when data is invalid", %{conn: conn} do
    event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen event", %{conn: conn} do
    event = fixture(:event)
    conn = delete conn, event_path(conn, :delete, event)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, event)
    end
  end
end
