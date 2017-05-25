defmodule Searchlight.Web.ServiceControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.Accounts

  @create_attrs %{auth_token: "some auth_token", base_uri: "some base_uri", client_id: "some client_id", client_secret: "some client_secret"}
  @update_attrs %{auth_token: "some updated auth_token", base_uri: "some updated base_uri", client_id: "some updated client_id", client_secret: "some updated client_secret"}
  @invalid_attrs %{auth_token: nil, base_uri: nil, client_id: nil, client_secret: nil}

  def fixture(:service) do
    {:ok, service} = Accounts.create_service(@create_attrs)
    service
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, service_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Services"
  end

  test "renders form for new services", %{conn: conn} do
    conn = get conn, service_path(conn, :new)
    assert html_response(conn, 200) =~ "New Service"
  end

  test "creates service and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), service: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == service_path(conn, :show, id)

    conn = get conn, service_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Service"
  end

  test "does not create service and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), service: @invalid_attrs
    assert html_response(conn, 200) =~ "New Service"
  end

  test "renders form for editing chosen service", %{conn: conn} do
    service = fixture(:service)
    conn = get conn, service_path(conn, :edit, service)
    assert html_response(conn, 200) =~ "Edit Service"
  end

  test "updates chosen service and redirects when data is valid", %{conn: conn} do
    service = fixture(:service)
    conn = put conn, service_path(conn, :update, service), service: @update_attrs
    assert redirected_to(conn) == service_path(conn, :show, service)

    conn = get conn, service_path(conn, :show, service)
    assert html_response(conn, 200) =~ "some updated auth_token"
  end

  test "does not update chosen service and renders errors when data is invalid", %{conn: conn} do
    service = fixture(:service)
    conn = put conn, service_path(conn, :update, service), service: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Service"
  end

  test "deletes chosen service", %{conn: conn} do
    service = fixture(:service)
    conn = delete conn, service_path(conn, :delete, service)
    assert redirected_to(conn) == service_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, service_path(conn, :show, service)
    end
  end
end
