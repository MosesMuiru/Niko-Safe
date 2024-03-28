defmodule NikoSafe.Communication.Sms do
  @moduledoc """

  I THE SMS WILL HAPPEN
    1. To send  a confirmation message to the user that you have 
      choosen them to be the people who will respond your emergency
      
      "
        Your Name has Choosen you to respond to emergency please respond


    "  

    2. To send you details of what you have entered as your details
        
        " THE FOLLOWING IS A LIST OF PEOPLE YOU HAVE CHOOSEN TO RESPONND TO YOUR EMERGENCY"

          07xxxx,07xxxxxx,07xxxxx

          your password is the following
          5252
          
  3. To send emergency messages
      
    " Moses has an emergency"


  4. To send notification to all the people you have choosen in your community that you have emergency
    "Moses Has AN emergency" 



  """

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
      "Hello #{data.name}!!\nThis are your details\nDevice #{data.garget_id}\nPhone numbers #{data.phone_number}\nGarget_id\nYour access pin}"

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

    # {:ok, response} = post("", attr)
    {:ok, response} = Gateway.post_to_at(attr, "sms")

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
