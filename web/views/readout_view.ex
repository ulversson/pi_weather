defmodule PiWeather.ReadoutView do
  use PiWeather.Web, :view

  def render("index.json", %{readouts: readouts}) do
    %{data: render_many(readouts, PiWeather.ReadoutView, "readout.json")}
  end

  def render("show.json", %{readout: readout}) do
    %{data: render_one(readout, PiWeather.ReadoutView, "readout.json")}
  end

  def render("readout.json", %{readout: readout}) do
    %{id: readout.id,
      temperature: readout.temperature,
      humidity: readout.humidity,
      pressure: readout.pressure,
      height: readout.height,
      dht22_temperature: readout.dht22_temperature}
  end
end
