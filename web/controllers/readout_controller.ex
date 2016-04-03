defmodule PiWeather.ReadoutController do
  use PiWeather.Web, :controller

  alias PiWeather.Readout

  plug :scrub_params, "readout" when action in [:create]

  def index(conn, _params) do
    readouts = Repo.all(Readout)
    render(conn, "index.json", readouts: readouts)
  end

  def create(conn, %{"readout" => readout_params}) do
    changeset = Readout.changeset(%Readout{}, readout_params)

    case Repo.insert(changeset) do
      {:ok, readout} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", readout_path(conn, :show, readout))
        |> render("show.json", readout: readout)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PiWeather.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    readout = Repo.get!(Readout, id)
    render(conn, "show.json", readout: readout)
  end

end
