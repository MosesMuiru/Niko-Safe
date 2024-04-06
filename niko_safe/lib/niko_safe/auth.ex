defmodule NikoSafe.Auth do
  alias NikoSafe.Device.Impl 
  alias NikoSafe.User.Impl, as: User
  @doc """

   This is where you authentication taks place

   You check if the garget with the given id exist

  Then check if the provided pin exists
  """

  @type attr :: %{
    device_unique_id: integer,
    unique_key: integer  
  }
  @spec auth(attr) :: any()
  def auth(attr) do

      device =  Impl.get_device_by_id(attr.device_unique_id) 
      user = User.by_unique_id(attr.unique_key)

       
      IO.puts("it working")
      IO.inspect(device.id == user.device_id)
      case device.id == user.device_id do
        true -> true
        _-> false
      end

      



  end


  
  

end
