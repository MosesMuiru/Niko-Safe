defmodule NikoSafeWeb.UssdController do
  alias NikoSafe.Communication.Sms
  alias NikoSafe.Communication.Ussd

  use NikoSafeWeb, :controller

  alias AtEx.USSD

  @docs """

  this should be able to test if the ussd is working
  the params should be

  sessionId
  serviceCOde
  phoneNumber
  text
  """

  def create(conn, params) do
    %{
      "sessionId" => _sessionId,
      "serviceCode" => _serviceCode,
      "phoneNumber" => phoneNumber,
      "text" => text
    } = params

    process_input(conn, phoneNumber, text)
  end

  defp process_input(conn, phoneNumber, <<head, _rest::binary>> = text) when head == ?1 do
    case count(text) do
      0 ->
        {_, response} = USSD.build_response("Enter Your name", :cont)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      1 ->
        {_, response} = USSD.build_response("Enter Your Garget Id")
        IO.puts("the reponse")
        IO.inspect(response)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      2 ->
        {_, response} =
          USSD.build_response(
            "Enter Number of people you want them to respond to your Emergencies, separate them with comma \n 0712xxxx,07xxxxx34,07XXXX232"
          )

        IO.inspect(text)

        conn
        |> put_status(:accepted)
        |> send_resp(202, response)

      3 ->
        data = Ussd.extract_data_from_ussd(text)

        # this will send messages to your phone to show details
        message_to_you = Sms.send_confirmation_message(phoneNumber, data)

        # this will be used to send messages confirmation messages to the users in the system
        message_to_responders =
          Sms.send_confirmation_message_to_responders(
            %{name: _name, phone_number: _phone_number} = data
          )

        # this is where the handling of error will occur
        case message_to_you and message_to_responders do
          101 ->
            {_, response} =
              USSD.build_response(" Confirmation has been sent to you and your responders")

            conn
            |> put_status(:ok)
            |> send_resp(200, response)

          _ ->
            {_, response} = USSD.build_response("Something went wrong please try again")

            conn
            |> put_status(400)
            |> send_resp(400, response)
        end

      _ ->
        IO.inspect(text)
        {_, response} = USSD.build_response("your have entered an invalid input", :end)

        conn
        |> put_status(404)
        |> send_resp(404, response)
    end
  end

  defp process_input(conn, _phoneNumber, <<head, _rest::binary>> = text) when head == ?2 do
    case count(text) do
      0 ->
        {_, response} = USSD.build_response("Enter garget pin", :cont)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      1 ->
        {_, response} = USSD.build_response("your details have been sent to your via sms", :end)

        conn
        |> put_status(:ok)
        |> send_resp(200, response)
    end
  end

  defp process_input(conn, _phoneNumber, text) do
    case text do
      "" ->
        {_, response} =
          USSD.build_response("Welcome to Niko Safe", [{1, "Register"}, {2, "Login"}, {0, "exit"}])

        IO.inspect(response)

        conn
        |> put_status(:created)
        |> send_resp(200, response)
    end
  end

  @spec count_level(String.t()) :: integer | String.t()
  defp count_level(string) do
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
