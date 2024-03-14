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

  plug Tesla.Middleware.BaseUrl, "https://voice.africastalking.com/call"

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
      (attr.username == "nikosafe" and type == "voice") or type == "sms" -> post_live(attr)
    end
  end

  defp post_live(attr) do
    post("", attr)
  end

  @doc """
  defp post_sandbox(attr) do
    
    plug Tesla.Middleware.Headers, {"apikey", Application.fetch_env!(:at_sandox, :api_key)}
    plug Tesla.Middleware.BaseUrl, @sms_url
    post("", attr)

  end
  """
end
