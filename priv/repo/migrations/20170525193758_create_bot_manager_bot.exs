defmodule Searchlight.Repo.Migrations.CreateSearchlight.BotManager.Bot do
  use Ecto.Migration

  def change do
    create table(:bot_manager_bots) do
      add :name, :string
      add :ip, :string
      add :active, :boolean, default: false, null: false
      add :created_date, :utc_datetime
      add :published_date, :utc_datetime
      add :claim_code, :string
      add :capabilities, :map

      timestamps()
    end

  end
end
