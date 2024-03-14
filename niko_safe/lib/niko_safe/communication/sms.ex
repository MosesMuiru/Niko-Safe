defmodule NikoSafe.Communication.Sms do
  use Tesla
  alias AtEx.Sms

  plug Tesla.Middleware.BaseUrl, "https://voice.africastalking.com/call"

  plug Tesla.Middleware.Headers, [
    {"accept", "application/json"},
    {"Content-Type", "application/x-www-form-urlencoded"},
    {"apikey", "953d6ce37d0b7e7ba2cc0974757eec0a93fa44fbf6c18b0807fe6c0f2db6a8e9"}
  ]

  # {"apikey", "de2fcba6e9fd0a7b683e8600b80f8c6070f834bdac0bf22560d00a12db8aa007"}]
  # {"apikey", "aa00212ade05662d24e4d238ccb4e6f9924017a0e82e49ceeca83d86c662958d"}] 
  plug Tesla.Middleware.FormUrlencoded

  @moduledoc """
    this will be used to to send bulk sms to muiltple users


  """
  def make_call do
    attrs = %{username: "nikosafe", from: "+254711082048", to: "+254794741095"}
    post("", attrs)
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
