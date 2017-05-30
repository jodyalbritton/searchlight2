defmodule Searchlight.Accounts.Device do
  use Ecto.Schema
  import Ecto.Changeset
  alias Searchlight.Accounts.Device


  schema "accounts_devices" do
    field :capabiltities, :map
    field :label, :string
    field :name, :string
    belongs_to :accounts_service, Searchlight.Accounts.Service

    timestamps()
  end

  @doc false
  def changeset(%Device{} = device, attrs) do
    device
    |> cast(attrs, [:name, :label, :capabiltities])
    |> validate_required([:name, :label, :capabiltities])
  end
end
