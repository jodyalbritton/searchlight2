defmodule Searchlight.BotManager.Bot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Searchlight.BotManager.Bot


  schema "bot_manager_bots" do
    field :active, :boolean, default: false
    field :capabilities, :map
    field :claim_code, :string
    field :created_date, :utc_datetime
    field :ip, :string
    field :name, :string
    field :published_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Bot{} = bot, attrs) do
    bot
    |> cast(attrs, [:name, :ip, :active, :created_date, :published_date, :active, :claim_code, :capabilities])
    |> validate_required([:name, :ip, :active, :created_date, :published_date, :active, :claim_code, :capabilities])
  end
end
