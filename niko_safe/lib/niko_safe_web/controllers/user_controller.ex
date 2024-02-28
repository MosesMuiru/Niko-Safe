defmodule NikoSafeWeb.UserController do
  use NikoSafeWeb, :controller


  def create(conn, %{"name" => name}) do
    IO.inspect(name)
    conn
    |> put_status(200)
    |> render("json", {name: name})
    
  end

end
