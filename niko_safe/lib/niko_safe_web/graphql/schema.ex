defmodule NikoSafeWeb.Schema do
  alias NikoSafe.User.Impl
  alias NikoSafe.Device.Impl, as: Device

  use Absinthe.Schema

  # you define the node here
  # this will be the shape of the data
  object :user do
    field :id, non_null(:integer)
    field :name, non_null(:string)
    field :phone_number, non_null(:string)
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
  query do
    field :user, list_of(:user), description: "the list of available users" do
      resolve(fn _, _, _ ->
        {:ok, Impl.get_all_users()}
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
    field :get_all_devices, :device do
      resolve(fn _, _, _ ->
        {:ok, Device.get_all_devices()}
      end)
    end
  end
end
