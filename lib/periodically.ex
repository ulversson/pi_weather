defmodule PiWeather.Periodically do
  use GenServer
  import PiWeather.Dht22  
  import PiWeather.Bmp180  
  alias PiWeather.ApiClient
	
  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    start_every_ten_minutes	
    {:ok, state}
  end

  def handle_info(:work, state) do
    ApiClient.post("readouts", prepare_params) 
		
    start_every_ten_minutes
 	
    {:noreply, state}
  end

  defp prepare_params do 
    {temperature, pressure, height} = bmp_values 
    {zero, dht22_temperature, humidity} = dht22_values

    %{readout: %{ temperature: temperature, 
		  pressure: pressure, 
		  height: height,
		  dht22_temperature: dht22_temperature, 
	  	  humidity: humidity
		}
     }		  		
  end

  defp start_every_ten_minutes, do: Process.send_after(self(), :work, 60*10)
end
