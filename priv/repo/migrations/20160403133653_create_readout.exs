defmodule PiWeather.Repo.Migrations.CreateReadout do
  use Ecto.Migration

  def change do
    create table(:readouts) do
      add :temperature, :decimal
      add :humidity, :decimal
      add :pressure, :decimal
      add :height, :decimal
      add :dht22_temperature, :string

      timestamps
    end

  end
end
