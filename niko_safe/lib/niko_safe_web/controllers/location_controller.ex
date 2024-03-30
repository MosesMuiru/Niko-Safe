defmodule NikoSafeWeb.LocationController do
  use NikoSafeWeb, :controller

  def create(conn, %{"latitude" => latitude, "longitude" => longitude}) do
    conn
    |> put_status(:created)
    |> json(%{latitude: latitude, longitude: longitude})
  end
end
