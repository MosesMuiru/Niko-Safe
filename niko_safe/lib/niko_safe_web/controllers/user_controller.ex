defmodule NikoSafeWeb.UserController do
  use NikoSafeWeb, :controller


  def create(conn,params) do
    #%{"name" => name, "phone_number": phone_number} = params 
    %{"name" => name, "phonenumber" => phonenumber} = params 
    IO.puts(name)
    conn
    |> put_status(:created)
    |> json(%{name: name, phone_number: phonenumber})
    #|> json(%{name: name, phone_number: phone_number})
#|> put_status(:created)
    #|> json(%{name: name, phone_number: phone_number}) 
  end

end
