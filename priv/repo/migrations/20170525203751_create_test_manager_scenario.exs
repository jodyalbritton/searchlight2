defmodule Searchlight.Repo.Migrations.CreateSearchlight.TestManager.Scenario do
  use Ecto.Migration

  def change do
    create table(:test_manager_scenarios) do
      add :name, :string

      timestamps()
    end

  end
end
