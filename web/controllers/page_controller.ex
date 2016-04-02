defmodule PiWeather.PageController do
  use PiWeather.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
