defmodule Searchlight.Accounts.Service do
  use Ecto.Schema
  import Ecto.Changeset
  alias Searchlight.Accounts.Service


  schema "accounts_services" do
    field :auth_token, :string
    field :base_uri, :string
    field :client_id, :string
    field :client_secret, :string
    has_many :devices, Searchlight.Accounts.Device
    timestamps()
  end

  @doc false
  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:client_id, :client_secret, :auth_token, :base_uri])
    |> validate_required([:client_id, :client_secret, :auth_token, :base_uri])
  end
end
