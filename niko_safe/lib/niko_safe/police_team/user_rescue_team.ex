defmodule NikoSafe.PoliceTeam.UserRescueTeam do
  # this will get the association between the police and the users 
  use Ecto.Schema
  alias NikoSafe.PoliceTeam.PoliceTeam
  alias NikoSafe.User.UserSchema

  schema "user_rescue_team" do
  belongs_to :police_team, PoliceTeam 
  belongs_to :user, UserSchema
  end

end
