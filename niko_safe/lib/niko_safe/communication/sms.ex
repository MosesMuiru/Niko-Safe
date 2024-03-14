defmodule NikoSafe.Communication.Sms do
  use Tesla
  alias AtEx.Sms
  alias NikoSafe.Gateway

  plug Tesla.Middleware.BaseUrl, "https://api.africastalking.com/version1/messaging"

  plug Tesla.Middleware.Headers, [
    {"accept", "application/json"},
    {"Content-Type", "application/x-www-form-urlencoded"},
    {"apikey", System.get_env("ATLIVE")}
  ]

  plug Tesla.Middleware.FormUrlencoded

  @moduledoc """
    this will be used to to send bulk sms to muiltple users


  """
  def make_call do
    attrs = %{username: "nikosafe", from: "+254711082048", to: "+254727243892"}

    Gateway.post_to_at(attrs, "voice")
  end

  # @spec send_confirmation_sms(list(String.t())) :: any()

  def send_confirmation_sms() do
    Sms.send_sms(%{to: "+254794741095", message: "hello"})
  end

  @doc """

    should send the details of the phone number you imput

    sample message
    moses
    has been registered to garget _ 35343

    phonenumber to receive notifications will be 
    0300323004

  """
  @spec send_confirmation_message(String.t(), map()) :: %{}
  def send_confirmation_message(phone_number, data) do
    message =
      "Hello #{data.name} details \nDevice #{data.garget_id}\n this are the phone numbers #{data.phone_number}"

    send_message(phone_number, message)
  end

  @spec send_alert(String.t()) :: %{}
  def send_alert(phone_number) do
    attr = %{username: "nikosafe", to: phone_number, message: "welcome to this home"}
    post("", attr)
  end

  @spec send_confirmation_message_to_responders(%{phone_number: String.t()}) :: any()
  def send_confirmation_message_to_responders(details) do
    message =
      "Hello ,incase of Emergencies #{details.name} , \n will be send an sms or call , \n Please Respond"

    send_message(details.phone_number, message)
  end

  @spec send_alert() :: {:error, String.t()}
  def send_alert do
    {:error, "cannot be empty"}
  end

  # sending details to user
  @spec send_details(String.t()) :: any()
  def send_details(phone_number) do
    message = "this are the details"
    send_message(phone_number, message)
  end

  @spec send_message(String.t(), String.t()) :: map()
  def send_message(phone_number, message) do
    attr = %{username: "nikosafe", to: phone_number, message: message}

    {:ok, response} = post("", attr)

    IO.puts("this si threres")
    [head | _tail] = decode_response(response.body)
    handle_error(head)
  end

  @spec handle_error(String.t()) :: any()
  defp handle_error(data) do
    data["statusCode"]
  end

  @spec decode_response(String.t()) :: any()
  defp decode_response(response) do
    respo = Jason.decode!(response)
    data = respo["SMSMessageData"]

    data["Recipients"]
  end
end
