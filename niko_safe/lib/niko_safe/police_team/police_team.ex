defmodule NikoSafe.PoliceTeam.PoliceTeam do
  use Ecto.Schema
  import Ecto.Changeset
  alias NikoSafe.User.UserSchema

  schema "police_team" do
    field :phone_number, :string
    field :station_name, :string

    timestamps()
    # the relationship
    # one police Team can have many user but one user can have on police team
    #
    # has_many :user, UserSchema
    many_to_many :user, UserSchema, join_through: NikoSafe.PoliceTeam.UserRescueTeam
  end

  def changeset(police_team, params \\ %{}) do
    police_team
    |> cast(params, [:phone_number, :station_name])
    |> validate_required([:phone_number, :station_name])
    |> validate_length(:phone_number, max: 13)
  end
end
