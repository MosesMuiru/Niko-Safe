defmodule NikoSafe.PoliceTeam.PoliceTeam do

  use Ecto.Schema
  import Ecto.Changeset

  schema "police_team" do
  field :phone_number, :string
  field :station_name, :string
  

  timestamps()
    # the relationship
    # one police Team can have many user but one user can have on police team
    #
    many_to_many :user, NikoSafe.User.UserSchema, join_through: Niko.PoliceTeam.UserRescueTeam
    
  end

end

