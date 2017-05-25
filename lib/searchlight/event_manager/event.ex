defmodule Searchlight.EventManager.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Searchlight.EventManager.Event


  schema "event_manager_events" do
    field :capability, :string
    field :current_iteration, :integer
    field :event_date, :utc_datetime
<<<<<<< HEAD
    field :latency, :string
    field :passed, :boolean, default: false
    field :source, :string
    field :unixtime, :integer
=======
    field :source, :string
    field :unix_time, :integer
>>>>>>> 994f7de165890167b2179a24826febe88ada0fad
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
<<<<<<< HEAD
    |> cast(attrs, [:value, :source, :capability, :current_iteration, :event_date, :unixtime, :latency, :passed])
    |> validate_required([:value, :source, :capability, :current_iteration, :event_date, :unixtime, :latency, :passed])
=======
    |> cast(attrs, [:value, :source, :capability, :current_iteration, :event_date, :unix_time])
    |> validate_required([:value, :source, :capability, :current_iteration, :event_date, :unix_time])
>>>>>>> 994f7de165890167b2179a24826febe88ada0fad
  end
end
