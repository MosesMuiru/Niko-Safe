defmodule NikoSafe.Communication.Voice do
  @moduledoc """
    this module will be used as the follow up call
    the follow up call is used after making an alert message
    the follow up call will take 5 mins after response
    

  """

  alias NikoSafe.Gateway

  @spec make_call(String.t()) :: any()
  def make_call(phone_numbers) do
    attrs = %{username: "nikosafe", from: "+254711082048", to: phone_numbers}

  {:ok, body} =  Gateway.post_to_at(attrs, "voice")
    body
  end
end
