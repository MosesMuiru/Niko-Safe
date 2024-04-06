defmodule NikoSafeWeb.Schema do
  alias NikoSafe.User.Impl
  alias NikoSafe.Device.Impl, as: Device

  use Absinthe.Schema

  # you define the node here
  # this will be the shape of the data
  object :user do
    field :id, non_null(:integer)
    field :name, non_null(:string)
    field :phone_number, :string
  end

  object :device do
    field :id, non_null(:integer)

    field :device_name, non_null(:string)
    field :device_unique_id, non_null(:integer)
  end

  def get_users do
    {:ok, Impl.get_all_users()}
  end

  # this discribes how to access the data or the node 
  @desc "get all Users"
  query do
    field :user, list_of(:user) do
      resolve(fn _, _, _ ->
        {:ok, Impl.get_all_users()}
      end)
    end 

    field :users, list_of(:user) do
      resolve(fn _, _, _ -> 
      
        {:ok, Impl.get_all()}
      end)

    end
    # this will get the user by id
    field :get_user_by_id, :user do
      arg(:id, non_null(:integer))

      resolve(fn _, %{id: id}, _ ->
        {:ok, Impl.get_user_id(id)}
      end)
    end

    # this queries for device
    field :get_all_devices, list_of :device do
      resolve(fn _, _, _ ->
        {:ok, Device.get_all_devices()}
      end)
    end
  end


  @doc """
    this is where the loading will take place
    loading -> this is fetching the data in batches

  """

  def context(ctx) do

    loader =
      Dataloader.new
      |> Dataloader.add_source(Impl, Impl.data())
      |> Dataloader.add_source(Device, Device.data())
    Map.put(ctx, :loader, loader)
  end


  @doc """
    you must define the plugin to be used 

  """

  def plugins do

    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end





end
