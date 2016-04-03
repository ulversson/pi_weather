defmodule PiWeather.Readout do
  use PiWeather.Web, :model

  schema "readouts" do
    field :temperature, :decimal
    field :humidity, :decimal
    field :pressure, :decimal
    field :height, :decimal
    field :dht22_temperature, :string

    timestamps
  end

  @required_fields ~w(temperature humidity pressure height dht22_temperature)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
