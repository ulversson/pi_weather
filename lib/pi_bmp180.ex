defmodule PiWeather.Bmp180 do 
  
  import PiWeather.PiShell
  
  def bmp_values do 
    bmp180_command
      |> run_shell
      |> Enum.map(fn (elem) -> Regex.replace(~r/[A-Za-z*|:]/, elem, "") |> String.strip end)
      |> List.to_tuple
    
  end  
  
  defp bmp180_command, do: "BMP180"
  
end
