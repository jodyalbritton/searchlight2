defmodule Searchlight.Repo.Migrations.CreateSearchlight.Accounts.Device do
  use Ecto.Migration

  def change do
    create table(:accounts_devices) do
      add :name, :string
      add :label, :string
      add :capabiltities, :map
      add :accounts_service_id, references(:accounts_services, on_delete: :nothing)

      timestamps()
    end

    create index(:accounts_devices, [:accounts_service_id])
  end
end
