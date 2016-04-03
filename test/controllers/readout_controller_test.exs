defmodule PiWeather.ReadoutControllerTest do
  use PiWeather.ConnCase

  alias PiWeather.Readout
  @valid_attrs %{dht22_temperature: "some content", height: "120.5", humidity: "120.5", pressure: "120.5", temperature: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, readout_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    readout = Repo.insert! %Readout{}
    conn = get conn, readout_path(conn, :show, readout)
    assert json_response(conn, 200)["data"] == %{"id" => readout.id,
      "temperature" => readout.temperature,
      "humidity" => readout.humidity,
      "pressure" => readout.pressure,
      "height" => readout.height,
      "dht22_temperature" => readout.dht22_temperature}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, readout_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, readout_path(conn, :create), readout: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Readout, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, readout_path(conn, :create), readout: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    readout = Repo.insert! %Readout{}
    conn = put conn, readout_path(conn, :update, readout), readout: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Readout, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    readout = Repo.insert! %Readout{}
    conn = put conn, readout_path(conn, :update, readout), readout: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    readout = Repo.insert! %Readout{}
    conn = delete conn, readout_path(conn, :delete, readout)
    assert response(conn, 204)
    refute Repo.get(Readout, readout.id)
  end
end
