defmodule NikoSafe.Device.Impl do


  defstruct device_name: nil, device_unique_id: nil

  alias NikoSafe.Device.DeviceSchema
  alias NikoSafe.User.UserSchema
  import Ecto.Changeset

  alias NikoSafe.Repo
  import Ecto.Query

  def data() do
    Dataloader.Ecto.new(NikoSafe.Repo, query: &query/2)
  end

  def query(queryable, _params), do: queryable

  def insert_device(device_name, unique_id) do
    DeviceSchema.changeset(%DeviceSchema{}, %{
      device_name: device_name,
      device_unique_id: unique_id
    })
    |> Repo.insert()
  end

  def get_all_devices do
    Repo.all(DeviceSchema)
  end

  def get_device_on_user_id(user_id) do
    query =
      from d in DeviceSchema,
        join: u in UserSchema,
        on: d.user_id == u.user_id,
        select: %Impl{
        device_name: d.device_name,
        device_unique_id: d.device_unique_id,
        name: u.name
    
    }
    Repo.all(query)
  end

  @spec get_device_by_id(integer) :: any()
  def get_device_by_id(unique_id) do

    query =
      from d in DeviceSchema,
      where: d.device_unique_id == ^unique_id,
      select: %{
        id: d.id,
        device_unique_id: d.device_unique_id
      }
    Repo.one(query)

  end
  # check if a device exists given its id
  def get_device_by_id!(unique_id) do
    query =
      from d in DeviceSchema,
        where: d.device_unique_id == ^unique_id

    Repo.exists?(query)
  end

  @doc """

    given a garget id in the db
    the user should assign a name to that id

    search the garget/ device with the given device id

  """

  def give_device_a_name(device_id, owner_name) do
    if get_device_by_id!(device_id) == true do
      device = Repo.get_by(DeviceSchema, device_unique_id: device_id)

      device = change(device, device_name: owner_name)

      case Repo.update(device) do
        {:ok, struct} ->
          struct
          true

        {:error, reason} ->
          reason
          false
      end
    else
      false
    end
  end

  defp update(newChangeset) do
    case Repo.update(newChangeset) do
      {:ok, struct} -> struct
      {:error, changeset} -> changeset
    end
  end
end
