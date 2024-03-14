defmodule Nikosafe.Gateway do

  use Tesla



  @voice_url "https://voice.africastalking.com/call" 
  @sms_url "https://api.africastalking.com/version1/messaging"

  plug Tesla.Middleware.Headers, [
    {"accept", "application/json"},
    {"Content-Type", "application/x-www-form-urlencoded"}
  ]
  plug Tesla.Middleware.FormUrlencoded
  

  @spec post_to_at(%{}, String.t()) :: any()
  def post_to_at(attr, type) do

    cond do
      attr.username == "nikosafe" and type == "voice" or type == "sms" -> post_live(attr)
      attr.username == "sandbox" -> post_sandbox(attr)
    end

  end

  defp post_live(attr) do
    
    plug Tesla.Middleware.BaseUrl, @voice_url
    post("", attr)
    

  end

  defp post_sandbox(attr) do
    plug Tesla.Middleware.BaseUrl, @sms_url
    post("", attr)

  end


  
end
