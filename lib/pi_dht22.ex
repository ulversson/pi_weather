defmodule PiWeather.Dht22 do 
  
  import PiWeather.PiShell
  
  def dht22_values do 
    dht22_command
      |> run_shell
      |> Enum.map(fn (elem) -> String.split(elem) end)
      |> List.first
      |> List.to_tuple
    
  end  
  
  defp dht22_command, do: "DHTXXD -g17"
  
end
