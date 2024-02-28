defmodule NikoSafeWeb.UserController do
  use NikoSafeWeb, :controller


  def create(conn, %{"name" => name}) do
    IO.inspect(name)
    conn
    |> put_status(:created)
    |> json( name: name)
    
  end

end
