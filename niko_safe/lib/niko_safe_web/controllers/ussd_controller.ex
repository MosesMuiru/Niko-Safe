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

    case count_level(text) do
      process_input(text)
      0 ->
        {_, response} = USSD.build_response("Welcome to Niko Safe", [{1,"Register"}, {2, "Login"}, {0, "exit"}])

      #  options(text)
      IO.puts("this is the response")
      IO.inspect(response)
        conn
        |> put_status(:created)
        |> send_resp(200, response)

     1 ->
        {_, response} = USSD.build_response("Enter Your name", :cont)
        conn
        |> put_status(:created)
        |> send_resp(200, response)


      2 -> 
        
        {_, response} = USSD.build_response("Welcome to Niko Safe", [{1,"Register"}, {2, "Login"}, {0, "exit"}])
        IO.puts("the reponse")
        IO.inspect(response)
        conn
        |> put_status(:created)
        |> send_resp(200, response)

   
      _->
        {_, response} = USSD.build_response("your have entered an invalid input", :end)
        conn
        |> put_status(404) 
        |> send_resp(404, response)
        
    end 

  end

  defp process_input(text) do

    case text do
      "" ->
        {_, response} = USSD.build_response("Welcome to Niko Safe", [{1,"Register"}, {2, "Login"}, {0, "exit"}])

      #  options(text)
      IO.puts("this is the response")
      IO.inspect(response)
        conn
        |> put_status(:created)
        |> send_resp(200, response)

  end
end

  defp process_input(text) when String.first(text) == 1 do
    
    case count(text) do


    end


  end


  @spec count_level(String.t()) :: integer | String.t()
  defp count_level(string)  do

    case String.first(string) do
    "1" -> count(string)
    "2" -> count(string)
    "" -> "" 
    _ -> 9


    end

  end

  defp count_levels(_text_input) do

  end

  @spec count(String.t()) :: integer
  defp count(string) do

    String.graphemes(string)
    |> Enum.count(&(&1 == "*"))

  end



def options(text_input) do

  
    case text_input do

    
      "1" ->
          {_, response} = USSD.build_response("Enter Your Garget Id")
          IO.inspect(response)
      "2" ->
        {:ok, _response} = USSD.build_response("Enter Yout password")

    end

  end

@spec register_garget(tuple()) :: any()
  defp register_garget(response) do
    IO.inspect(response)
    
  
  end

end
