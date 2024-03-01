defmodule NikoSafeWeb.UssdController do
  use NikoSafeWeb, :controller

  alias AtEx.USSD

 @docs"""

  this should be able to test if the ussd is working
  the params should be

  sessionId
  serviceCOde
  phoneNumber
  text
  """

  def create(conn, params) do
    %{"sessionId" => _sessionId, "serviceCode" => _serviceCode, "phoneNumber" => _phoneNumber, "text" => text} =  params
    #%{"text" => text} = params
    case text do
      "" ->
        {_, response} = USSD.build_response([{1,"first ussd"}])
        conn
        |> put_status(:created)
        |> send_resp(200, response)
      _->
        conn
        |> put_status(404) 
        |> send_resp(404, "NOT FOUND")
        IO.puts("failed")
    end 

  end

end
