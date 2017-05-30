defmodule Searchlight.Web.ScenarioController do
  use Searchlight.Web, :controller

  alias Searchlight.TestManager

  def index(conn, _params) do
    scenarios = TestManager.list_scenarios()
    render(conn, "index.html", scenarios: scenarios)
  end

  def new(conn, _params) do
    changeset = TestManager.change_scenario(%Searchlight.TestManager.Scenario{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scenario" => scenario_params}) do
    case TestManager.create_scenario(scenario_params) do
      {:ok, scenario} ->
        conn
        |> put_flash(:info, "Scenario created successfully.")
        |> redirect(to: scenario_path(conn, :show, scenario))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scenario = TestManager.get_scenario!(id)
    render(conn, "show.html", scenario: scenario)
  end

  def edit(conn, %{"id" => id}) do
    scenario = TestManager.get_scenario!(id)
    changeset = TestManager.change_scenario(scenario)
    render(conn, "edit.html", scenario: scenario, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scenario" => scenario_params}) do
    scenario = TestManager.get_scenario!(id)

    case TestManager.update_scenario(scenario, scenario_params) do
      {:ok, scenario} ->
        conn
        |> put_flash(:info, "Scenario updated successfully.")
        |> redirect(to: scenario_path(conn, :show, scenario))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", scenario: scenario, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scenario = TestManager.get_scenario!(id)
    {:ok, _scenario} = TestManager.delete_scenario(scenario)

    conn
    |> put_flash(:info, "Scenario deleted successfully.")
    |> redirect(to: scenario_path(conn, :index))
  end
end
