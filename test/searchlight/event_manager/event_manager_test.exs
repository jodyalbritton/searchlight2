defmodule Searchlight.EventManagerTest do
  use Searchlight.DataCase

  alias Searchlight.EventManager

  describe "events" do
    alias Searchlight.EventManager.Event

    @valid_attrs %{capability: "some capability", current_iteration: 42, event_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, source: "some source", unix_time: 42, value: "some value"}
    @update_attrs %{capability: "some updated capability", current_iteration: 43, event_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, source: "some updated source", unix_time: 43, value: "some updated value"}
    @invalid_attrs %{capability: nil, current_iteration: nil, event_date: nil, source: nil, unix_time: nil, value: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EventManager.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert EventManager.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert EventManager.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = EventManager.create_event(@valid_attrs)
      assert event.capability == "some capability"
      assert event.current_iteration == 42
      assert event.event_date == %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}
      assert event.source == "some source"
      assert event.unix_time == 42
      assert event.value == "some value"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventManager.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = EventManager.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.capability == "some updated capability"
      assert event.current_iteration == 43
      assert event.event_date == %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}
      assert event.source == "some updated source"
      assert event.unix_time == 43
      assert event.value == "some updated value"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = EventManager.update_event(event, @invalid_attrs)
      assert event == EventManager.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = EventManager.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> EventManager.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = EventManager.change_event(event)
    end
  end
end
