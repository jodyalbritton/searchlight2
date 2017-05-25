defmodule Searchlight.Repo.Migrations.CreateSearchlight.Accounts.Service do
  use Ecto.Migration

  def change do
    create table(:accounts_services) do
      add :client_id, :string
      add :client_secret, :string
      add :auth_token, :string
      add :base_uri, :string

      timestamps()
    end

  end
end
