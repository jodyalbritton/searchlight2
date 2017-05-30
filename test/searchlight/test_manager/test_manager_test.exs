defmodule Searchlight.TestManagerTest do
  use Searchlight.DataCase

  alias Searchlight.TestManager

  describe "tests" do
    alias Searchlight.TestManager.Test

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def test_fixture(attrs \\ %{}) do
      {:ok, test} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TestManager.create_test()

      test
    end

    test "list_tests/0 returns all tests" do
      test = test_fixture()
      assert TestManager.list_tests() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert TestManager.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      assert {:ok, %Test{} = test} = TestManager.create_test(@valid_attrs)
      assert test.name == "some name"
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestManager.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      assert {:ok, test} = TestManager.update_test(test, @update_attrs)
      assert %Test{} = test
      assert test.name == "some updated name"
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = TestManager.update_test(test, @invalid_attrs)
      assert test == TestManager.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = TestManager.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> TestManager.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = TestManager.change_test(test)
    end
  end

  describe "scenarios" do
    alias Searchlight.TestManager.Scenario

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def scenario_fixture(attrs \\ %{}) do
      {:ok, scenario} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TestManager.create_scenario()

      scenario
    end

    test "list_scenarios/0 returns all scenarios" do
      scenario = scenario_fixture()
      assert TestManager.list_scenarios() == [scenario]
    end

    test "get_scenario!/1 returns the scenario with given id" do
      scenario = scenario_fixture()
      assert TestManager.get_scenario!(scenario.id) == scenario
    end

    test "create_scenario/1 with valid data creates a scenario" do
      assert {:ok, %Scenario{} = scenario} = TestManager.create_scenario(@valid_attrs)
      assert scenario.name == "some name"
    end

    test "create_scenario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestManager.create_scenario(@invalid_attrs)
    end

    test "update_scenario/2 with valid data updates the scenario" do
      scenario = scenario_fixture()
      assert {:ok, scenario} = TestManager.update_scenario(scenario, @update_attrs)
      assert %Scenario{} = scenario
      assert scenario.name == "some updated name"
    end

    test "update_scenario/2 with invalid data returns error changeset" do
      scenario = scenario_fixture()
      assert {:error, %Ecto.Changeset{}} = TestManager.update_scenario(scenario, @invalid_attrs)
      assert scenario == TestManager.get_scenario!(scenario.id)
    end

    test "delete_scenario/1 deletes the scenario" do
      scenario = scenario_fixture()
      assert {:ok, %Scenario{}} = TestManager.delete_scenario(scenario)
      assert_raise Ecto.NoResultsError, fn -> TestManager.get_scenario!(scenario.id) end
    end

    test "change_scenario/1 returns a scenario changeset" do
      scenario = scenario_fixture()
      assert %Ecto.Changeset{} = TestManager.change_scenario(scenario)
    end
  end
end
