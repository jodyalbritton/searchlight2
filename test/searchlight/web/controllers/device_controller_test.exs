defmodule Searchlight.Web.DeviceControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.Accounts

  @create_attrs %{capabiltities: %{}, label: "some label", name: "some name"}
  @update_attrs %{capabiltities: %{}, label: "some updated label", name: "some updated name"}
  @invalid_attrs %{capabiltities: nil, label: nil, name: nil}

  def fixture(:device) do
    {:ok, device} = Accounts.create_device(@create_attrs)
    device
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, device_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Devices"
  end

  test "renders form for new devices", %{conn: conn} do
    conn = get conn, device_path(conn, :new)
    assert html_response(conn, 200) =~ "New Device"
  end

  test "creates device and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, device_path(conn, :create), device: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == device_path(conn, :show, id)

    conn = get conn, device_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Device"
  end

  test "does not create device and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, device_path(conn, :create), device: @invalid_attrs
    assert html_response(conn, 200) =~ "New Device"
  end

  test "renders form for editing chosen device", %{conn: conn} do
    device = fixture(:device)
    conn = get conn, device_path(conn, :edit, device)
    assert html_response(conn, 200) =~ "Edit Device"
  end

  test "updates chosen device and redirects when data is valid", %{conn: conn} do
    device = fixture(:device)
    conn = put conn, device_path(conn, :update, device), device: @update_attrs
    assert redirected_to(conn) == device_path(conn, :show, device)

    conn = get conn, device_path(conn, :show, device)
    assert html_response(conn, 200) =~ "some updated label"
  end

  test "does not update chosen device and renders errors when data is invalid", %{conn: conn} do
    device = fixture(:device)
    conn = put conn, device_path(conn, :update, device), device: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Device"
  end

  test "deletes chosen device", %{conn: conn} do
    device = fixture(:device)
    conn = delete conn, device_path(conn, :delete, device)
    assert redirected_to(conn) == device_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, device_path(conn, :show, device)
    end
  end
end
