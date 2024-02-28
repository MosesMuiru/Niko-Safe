defmodule NikoSafeWeb.UserController do
  use NikoSafeWeb, :controller


  def create(conn, %{"name" => name, "phone_number" => phone_number}) do
    IO.inspect(name)
    conn
    |> put_status(:created)
    |> json(%{name: name, phone_number: phone_number})
    
  end

end
