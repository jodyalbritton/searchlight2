defmodule Searchlight.Repo.Migrations.CreateSearchlight.EventManager.Event do
  use Ecto.Migration

  def change do
    create table(:event_manager_events) do
      add :value, :string
      add :source, :string
      add :capability, :string
      add :current_iteration, :integer
      add :event_date, :utc_datetime
      add :unix_time, :integer

      timestamps()
    end

  end
end
