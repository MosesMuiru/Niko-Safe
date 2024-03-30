defmodule NikoSafeWeb.UssdController do
  alias NikoSafe.Communication.Sms
  alias NikoSafe.Communication.Ussd
  alias NikoSafe.Device.Impl
  alias NikoSafe.User.Impl, as: User

  use GenServer
  alias NikoSafe.CommunicationServer

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
    IO.inspect(params)

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
        {_, response} =
          USSD.build_response("Enter Your name that your responders know you by", :cont)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      1 ->
        {_, response} = USSD.build_response("Enter Your Garget Id")

        IO.inspect(response)

        # check if the garget exists in the db

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      2 ->
        {_, response} =
          USSD.build_response(
            "Enter Numbers of people you want them to respond to your Emergencies, separate them with comma \n 0712xxxx,07xxxxx34,07XXXX232"
          )

        IO.inspect(text)

        conn
        |> put_status(:accepted)
        |> send_resp(202, response)

      3 ->
        data = Ussd.extract_data_from_ussd(text)

        User.insert_to_db(%{
          name: data.name,
          phone_number: phoneNumber,
          emergency_responders: data.phone_number
        })
        |> IO.inspect()

        IO.inspect(data.phone_number)
        # extract data -> check if the garget exists -> assign to the user and name it like that
        %{garget_id: device_unique_id, name: name} = data
        device_confirmation = Impl.give_device_a_name(device_unique_id, name)
        IO.puts("this is the device confirm")
        IO.puts(device_confirmation)
        # this will send messages to your phone to show details
        # message_to_you = Sms.send_confirmation_message(phoneNumber, data)
        message_to_you =
          GenServer.call(
            CommunicationServer,
            {:send_confirm_message, %{phone_number: phoneNumber, data: data}}
          )

        # this will be used to send messages confirmation messages to the users in the system
        #  message_to_responders =
        # Sms.send_confirmation_message_to_responders(
        #   %{name: _name, phone_number: _phone_number} = data
        # )
        message_to_responders =
          GenServer.call(
            CommunicationServer,
            {:to_responders, %{phone_number: phoneNumber, data: data}}
          )

        #
        IO.inspect(message_to_you)
        IO.inspect(message_to_responders)

        # this is where the handling of error will occur
        case message_to_you == 101 and message_to_responders == 101 and device_confirmation do
          true ->
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
        {_, response} = USSD.build_response("Enter your garget id", :cont)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)

      1 ->
        {_, response} = USSD.build_response("your details have been sent to your via sms", :end)

        conn
        |> put_status(:ok)
        |> send_resp(200, response)

      _ ->
        {_, response} = USSD.build_response("Check you details")

        conn
        |> put_status(204)
        |> send_resp(204, response)
    end
  end

  defp process_input(conn, _phoneNumber, <<head, _rest::binary>> = text) when head == ?0 do
    case count(text) do
      0 ->
        {_, response} = USSD.build_response("Enter your garget id", :cont)

        conn
        |> put_status(:accepted)
        |> send_resp(200, response)
    end
  end

  defp process_input(conn, _phoneNumber, text) do
    case text do
      "" ->
        {_, response} =
          USSD.build_response("Welcome to Niko Safe", [{1, "Register"}, {2, "Login"}])

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
  def count(string) do
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
