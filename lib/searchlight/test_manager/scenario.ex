defmodule Searchlight.TestManager.Scenario do
  use Ecto.Schema
  import Ecto.Changeset
  alias Searchlight.TestManager.Scenario


  schema "test_manager_scenarios" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Scenario{} = scenario, attrs) do
    scenario
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
