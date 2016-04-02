ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PiWeather.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PiWeather.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PiWeather.Repo)

