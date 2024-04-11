defmodule NikoSafeWeb.TriggerController do
  use NikoSafeWeb, :controller
  alias NikoSafe.User.Impl
  alias NikoSafe.CommunicationServer

  use GenServer

  def create(conn, %{"device_id" => device_id}) do
    # reques the name of user from db based the garget id
    # send the details to the genserver to trigger the call

    IO.inspect(device_id)
    response =  fetch_details(device_id)


    IO.inspect(response)
    conn
    |> put_status(response.sms)
    |> send_resp(200, " emergency call made")

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
