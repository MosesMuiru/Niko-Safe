defmodule NikoSafeWeb.TriggerController do
  use NikoSafeWeb, :controller
  alias NikoSafe.User.Impl
  alias NikoSafe.CommunicationServer

  use GenServer

  def create(conn, %{"device_id" => device_id}) do
    # reques the name of user from db based the garget id
    # send the details to the genserver to trigger the call

    response =  fetch_details(device_id)

    conn
    |> put_status(response.sms)
    |> send_resp(response.voice, "voice sent")

  end

  @type details :: %{
          emergency_responders: String.t(),
          name: String.t()
        }
  @spec fetch_details(integer()) :: details
  defp fetch_details(device_id) do
     
   details =  Impl.by_device_id(device_id)
    |> Enum.at(0)
   GenServer.call(CommunicationServer, {:trigger_for_help, details})

  end
end
