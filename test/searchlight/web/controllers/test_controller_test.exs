defmodule Searchlight.Web.TestControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.TestManager

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:test) do
    {:ok, test} = TestManager.create_test(@create_attrs)
    test
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, test_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Tests"
  end

  test "renders form for new tests", %{conn: conn} do
    conn = get conn, test_path(conn, :new)
    assert html_response(conn, 200) =~ "New Test"
  end

  test "creates test and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, test_path(conn, :create), test: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == test_path(conn, :show, id)

    conn = get conn, test_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Test"
  end

  test "does not create test and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, test_path(conn, :create), test: @invalid_attrs
    assert html_response(conn, 200) =~ "New Test"
  end

  test "renders form for editing chosen test", %{conn: conn} do
    test = fixture(:test)
    conn = get conn, test_path(conn, :edit, test)
    assert html_response(conn, 200) =~ "Edit Test"
  end

  test "updates chosen test and redirects when data is valid", %{conn: conn} do
    test = fixture(:test)
    conn = put conn, test_path(conn, :update, test), test: @update_attrs
    assert redirected_to(conn) == test_path(conn, :show, test)

    conn = get conn, test_path(conn, :show, test)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen test and renders errors when data is invalid", %{conn: conn} do
    test = fixture(:test)
    conn = put conn, test_path(conn, :update, test), test: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Test"
  end

  test "deletes chosen test", %{conn: conn} do
    test = fixture(:test)
    conn = delete conn, test_path(conn, :delete, test)
    assert redirected_to(conn) == test_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, test_path(conn, :show, test)
    end
  end
end
