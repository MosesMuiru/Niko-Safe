defmodule NikoSafe.Emergency.EmergencySchema do
  use Ecto.Schema
  import Ecto.Changeset

  alias NikoSafe.User.UserSchema

  schema "emergency" do
    field :health, :string
    field :tragedy, :string

    timestamps()
    belongs_to :user, UserSchema, foreign_key: :user_id
  end

  def changeset(emergency, params \\ {}) do
    emergency
    |> cast(params, [:health, :tragendy])
    
  end
end
