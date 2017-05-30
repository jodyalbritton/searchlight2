defmodule Searchlight.Repo.Migrations.CreateSearchlight.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :name, :string
      add :email, :string
      add :password, :string

      timestamps()
    end

  end
end
