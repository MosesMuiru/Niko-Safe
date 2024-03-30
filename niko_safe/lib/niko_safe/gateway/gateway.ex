defmodule NikoSafe.Gateway do
  use Tesla

  @moduledoc """

  this is a gateway for tesla to communicate to send post request to africastalking api


  """
  plug Tesla.Middleware.Headers, [
    {"accept", "application/json"},
    {"Content-Type", "application/x-www-form-urlencoded"},
    {"apikey", System.get_env("ATLIVE")}
  ]

  plug Tesla.Middleware.FormUrlencoded

  # plug Tesla.Middleware.BaseUrl, "https://voice.africastalking.com/call"

  @voice_url "https://voice.africastalking.com/call"
  @sms_url "https://api.africastalking.com/version1/messaging"

  @doc """
   the post recieves attributes and the type
    the type in this case is either voice or sms
    the difference will trigger differect post
  """
  def api do
    System.get_env("ATLIVE")
  end

  @spec post_to_at(%{}, String.t()) :: any()
  def post_to_at(attr, type) do
    cond do
      attr.username == "nikosafe" and type == "voice" -> post_live(attr)
      attr.username == "nikosafe" and type == "sms" -> post_sms(attr)
    end
  end

  defp post_live(attr) do
    post("https://voice.africastalking.com/call", attr)
  end

  @typep sms_attr :: %{
           username: String.t(),
           to: String.t(),
           message: String.t()
         }
  @spec post_sms(sms_attr) :: any()
  defp post_sms(sms_attr) do
    post(@sms_url, sms_attr)
  end
end
