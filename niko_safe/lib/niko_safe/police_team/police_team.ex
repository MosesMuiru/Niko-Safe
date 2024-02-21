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
    has_many :police_team, NikoSafe.PoliceTeam.PoliceTeam
  end
end
