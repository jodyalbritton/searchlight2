defmodule Searchlight.Repo.Migrations.CreateSearchlight.TestManager.Test do
  use Ecto.Migration

  def change do
    create table(:test_manager_tests) do
      add :name, :string

      timestamps()
    end

  end
end
