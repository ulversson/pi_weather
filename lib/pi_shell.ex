defmodule PiWeather.PiShell do 

  def run_shell(command) do 
      command
      |> String.to_char_list
      |> :os.cmd
      |> to_string
      |> String.split("\n", trim: true)	
  end		
	
end
