defmodule Searchlight.TestManager do
  @moduledoc """
  The boundary for the TestManager system.
  """

  import Ecto.Query, warn: false
  alias Searchlight.Repo

  alias Searchlight.TestManager.Test

  @doc """
  Returns the list of tests.

  ## Examples

      iex> list_tests()
      [%Test{}, ...]

  """
  def list_tests do
    Repo.all(Test)
  end

  @doc """
  Gets a single test.

  Raises `Ecto.NoResultsError` if the Test does not exist.

  ## Examples

      iex> get_test!(123)
      %Test{}

      iex> get_test!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test!(id), do: Repo.get!(Test, id)

  @doc """
  Creates a test.

  ## Examples

      iex> create_test(%{field: value})
      {:ok, %Test{}}

      iex> create_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test(attrs \\ %{}) do
    %Test{}
    |> Test.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test.

  ## Examples

      iex> update_test(test, %{field: new_value})
      {:ok, %Test{}}

      iex> update_test(test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test(%Test{} = test, attrs) do
    test
    |> Test.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Test.

  ## Examples

      iex> delete_test(test)
      {:ok, %Test{}}

      iex> delete_test(test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test(%Test{} = test) do
    Repo.delete(test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test changes.

  ## Examples

      iex> change_test(test)
      %Ecto.Changeset{source: %Test{}}

  """
  def change_test(%Test{} = test) do
    Test.changeset(test, %{})
  end

  alias Searchlight.TestManager.Scenario

  @doc """
  Returns the list of scenarios.

  ## Examples

      iex> list_scenarios()
      [%Scenario{}, ...]

  """
  def list_scenarios do
    Repo.all(Scenario)
  end

  @doc """
  Gets a single scenario.

  Raises `Ecto.NoResultsError` if the Scenario does not exist.

  ## Examples

      iex> get_scenario!(123)
      %Scenario{}

      iex> get_scenario!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scenario!(id), do: Repo.get!(Scenario, id)

  @doc """
  Creates a scenario.

  ## Examples

      iex> create_scenario(%{field: value})
      {:ok, %Scenario{}}

      iex> create_scenario(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scenario(attrs \\ %{}) do
    %Scenario{}
    |> Scenario.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scenario.

  ## Examples

      iex> update_scenario(scenario, %{field: new_value})
      {:ok, %Scenario{}}

      iex> update_scenario(scenario, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scenario(%Scenario{} = scenario, attrs) do
    scenario
    |> Scenario.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Scenario.

  ## Examples

      iex> delete_scenario(scenario)
      {:ok, %Scenario{}}

      iex> delete_scenario(scenario)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scenario(%Scenario{} = scenario) do
    Repo.delete(scenario)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scenario changes.

  ## Examples

      iex> change_scenario(scenario)
      %Ecto.Changeset{source: %Scenario{}}

  """
  def change_scenario(%Scenario{} = scenario) do
    Scenario.changeset(scenario, %{})
  end
end
