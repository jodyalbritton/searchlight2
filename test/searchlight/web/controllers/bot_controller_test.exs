defmodule Searchlight.Web.BotControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.BotManager

  @create_attrs %{active: true, capabilities: %{}, claim_code: "some claim_code", created_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, ip: "some ip", name: "some name", published_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}}
  @update_attrs %{active: false, capabilities: %{}, claim_code: "some updated claim_code", created_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, ip: "some updated ip", name: "some updated name", published_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}}
  @invalid_attrs %{active: nil, capabilities: nil, claim_code: nil, created_date: nil, ip: nil, name: nil, published_date: nil}

  def fixture(:bot) do
    {:ok, bot} = BotManager.create_bot(@create_attrs)
    bot
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bot_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Bots"
  end

  test "renders form for new bots", %{conn: conn} do
    conn = get conn, bot_path(conn, :new)
    assert html_response(conn, 200) =~ "New Bot"
  end

  test "creates bot and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, bot_path(conn, :create), bot: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == bot_path(conn, :show, id)

    conn = get conn, bot_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Bot"
  end

  test "does not create bot and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bot_path(conn, :create), bot: @invalid_attrs
    assert html_response(conn, 200) =~ "New Bot"
  end

  test "renders form for editing chosen bot", %{conn: conn} do
    bot = fixture(:bot)
    conn = get conn, bot_path(conn, :edit, bot)
    assert html_response(conn, 200) =~ "Edit Bot"
  end

  test "updates chosen bot and redirects when data is valid", %{conn: conn} do
    bot = fixture(:bot)
    conn = put conn, bot_path(conn, :update, bot), bot: @update_attrs
    assert redirected_to(conn) == bot_path(conn, :show, bot)

    conn = get conn, bot_path(conn, :show, bot)
    assert html_response(conn, 200) =~ "some updated claim_code"
  end

  test "does not update chosen bot and renders errors when data is invalid", %{conn: conn} do
    bot = fixture(:bot)
    conn = put conn, bot_path(conn, :update, bot), bot: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Bot"
  end

  test "deletes chosen bot", %{conn: conn} do
    bot = fixture(:bot)
    conn = delete conn, bot_path(conn, :delete, bot)
    assert redirected_to(conn) == bot_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, bot_path(conn, :show, bot)
    end
  end
end
