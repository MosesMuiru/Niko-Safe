defmodule NikoSafe.Emergency.EmergencySchema do
  use Ecto.Schema
  import Ecto.Changeset

  alias NikoSafe.User.UserSchema

  schema "emergency" do
    field :distress_message, :string

    belongs_to :user, UserSchema, foreign_key: :user_id
    timestamps()
  end

  # def changeset(emergency, params \\ {}) do
  #  emergency
  # |> cast(params, [:health, :tragedy])
  #    |> validate_required([:health, :tragedy]) 
  # end
end
