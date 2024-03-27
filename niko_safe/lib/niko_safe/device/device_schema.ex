defmodule NikoSafe.Device.DeviceSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias NikoSafe.User.UserSchema

  schema "device" do
    field :device_name, :string
    field :device_unique_id, :integer

    timestamps()
  end

  def changeset(device, params \\ %{}) do
    device
    |> cast(params, [:device_name, :device_unique_id])
    |> validate_required([:device_unique_id])
    |> unique_constraint([:device_unique_id, :device_name])
  end
end
