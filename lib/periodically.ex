defmodule PiWeather.Periodically do
  use GenServer
  import PiWeather.Dht22  
  import PiWeather.Bmp180  

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    start_every_10_sec	
    {:ok, state}
  end

  def handle_info(:work, state) do
    IO.puts "OK" 		

    start_every_10_sec
 	
    {:noreply, state}
  end

  defp start_every_10_sec, do: Process.send_after(self(), :work, 1)
end
