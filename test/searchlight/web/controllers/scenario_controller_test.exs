defmodule Searchlight.Web.ScenarioControllerTest do
  use Searchlight.Web.ConnCase

  alias Searchlight.TestManager

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:scenario) do
    {:ok, scenario} = TestManager.create_scenario(@create_attrs)
    scenario
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, scenario_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Scenarios"
  end

  test "renders form for new scenarios", %{conn: conn} do
    conn = get conn, scenario_path(conn, :new)
    assert html_response(conn, 200) =~ "New Scenario"
  end

  test "creates scenario and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, scenario_path(conn, :create), scenario: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == scenario_path(conn, :show, id)

    conn = get conn, scenario_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Scenario"
  end

  test "does not create scenario and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scenario_path(conn, :create), scenario: @invalid_attrs
    assert html_response(conn, 200) =~ "New Scenario"
  end

  test "renders form for editing chosen scenario", %{conn: conn} do
    scenario = fixture(:scenario)
    conn = get conn, scenario_path(conn, :edit, scenario)
    assert html_response(conn, 200) =~ "Edit Scenario"
  end

  test "updates chosen scenario and redirects when data is valid", %{conn: conn} do
    scenario = fixture(:scenario)
    conn = put conn, scenario_path(conn, :update, scenario), scenario: @update_attrs
    assert redirected_to(conn) == scenario_path(conn, :show, scenario)

    conn = get conn, scenario_path(conn, :show, scenario)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen scenario and renders errors when data is invalid", %{conn: conn} do
    scenario = fixture(:scenario)
    conn = put conn, scenario_path(conn, :update, scenario), scenario: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Scenario"
  end

  test "deletes chosen scenario", %{conn: conn} do
    scenario = fixture(:scenario)
    conn = delete conn, scenario_path(conn, :delete, scenario)
    assert redirected_to(conn) == scenario_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, scenario_path(conn, :show, scenario)
    end
  end
end
