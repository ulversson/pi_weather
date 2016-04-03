defmodule PiWeather.ReadoutTest do
  use PiWeather.ModelCase

  alias PiWeather.Readout

  @valid_attrs %{dht22_temperature: "some content", height: "120.5", humidity: "120.5", pressure: "120.5", temperature: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Readout.changeset(%Readout{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Readout.changeset(%Readout{}, @invalid_attrs)
    refute changeset.valid?
  end
end
