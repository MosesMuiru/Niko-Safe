defmodule NikoSafe.User.UserSchema do
  # this is where the schema will be defindd
  # garget -> this is used to create a relationship between the user and the garget

  use Ecto.Schema

  schema "user" do
    field :name, :string
    field :phone_number, :string
# relationship with the
   has_one :garget, NikoSafe.Garget.GargetSchema
 
   has_one :emergency, NikoSage.Emergency.EmergencySchema

   many_to_many :police_team, NikoSafe.PoliceTeam.PoliceTeam, join_through: NikoSafe.PoliceTeam.UserRescueTeam 
  end
end
