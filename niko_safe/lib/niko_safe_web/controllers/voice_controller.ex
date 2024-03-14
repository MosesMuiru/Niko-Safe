defmodule NikoSafeWeb.VoiceController do
  use NikoSafeWeb, :controller

  @doc """
     i should have a an xml file that will contain data that will be said in the calll

  """

  def create(conn, params) do
    IO.inspect(params)

    xml_response = xml_response()

    conn
    |> put_status(200)
    |> put_resp_content_type("text/plain")
    |> send_resp(200, xml_response)
  end

  @spec xml_response() :: any()
  defp xml_response do
    ~s(<?xml version="1.0" encoding="UTF-8"?>
<Response>
    <Say voice="en-US-Standard-C" playBeep="false" >Moses has an Emergency</Say>
</Response> 
    )
  end
end
