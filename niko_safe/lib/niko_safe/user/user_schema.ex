defmodule NikoSafe.User.UserSchema do
  # this is where the schema will be defindd
  # garget -> this is used to create a relationship between the user and the garget
  alias NikoSafe.Garget.GargetSchema
  use Ecto.Schema
  import Ecto.Changeset
  alias NikoSafe.Rescue.RescueTeam
  alias NikoSafe.Device.DeviceSchema

  @optional_fields [:id, :inserted_at, :updated_at, :garget_id, :emergency_id, :rescue_team]
  schema "user" do
    field :name, :string
    field :phone_number, :string
    # relationship with the garget
    has_one :device, DeviceSchema
    has_many :garget, GargetSchema, foreign_key: :user_id
    has_many :emergency, NikoSafe.Emergency.EmergencySchema, foreign_key: :emergency_id

    # many_to_many :police_team, NikoSafe.PoliceTeam.PoliceTeam,
    # join_through: NikoSafe.PoliceTeam.UserRescueTeam
    has_many :rescue_team, RescueTeam, foreign_key: :user_id

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, all_fields() -- @optional_fields)
    |> validate_required(all_fields() -- @optional_fields)
    |> validate_length(:phone_number, min: 10, max: 14)
  end
end
