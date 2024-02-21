defmodule NikoSafe.User.UserSchema do
  # this is where the schema will be defindd
  # garget -> this is used to create a relationship between the user and the garget
  alias NikoSafe.Garget.GargetSchema
  use Ecto.Schema

  schema "user" do
    field :name, :string
    field :phone_number, :string
    # relationship with the garget
    has_many :gargets, GargetSchema, foreign_key: :user_id
    has_many :emergency, NikoSafe.Emergency.EmergencySchema, foreign_key: :emergency_id
    many_to_many :police_team, NikoSafe.PoliceTeam.PoliceTeam, join_through: NikoSafe.PoliceTeam.UserRescueTeam

   timestamps() 
  end
end
