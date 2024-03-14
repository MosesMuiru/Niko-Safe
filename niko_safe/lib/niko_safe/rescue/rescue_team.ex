defmodule NikoSafe.Rescue.RescueTeam do
  use Ecto.Schema
  import Ecto.Changeset
  alias NikoSafe.User.UserSchema

  schema "rescue_team" do
    field :name, :string
    field :phone_number, :string
    field :message, :string, default: "help me"

    belongs_to :user, UserSchema, foreign_key: :user_id
  end

  def changeset(rescue_team, params \\ %{}) do
    rescue_team
    |> cast(params, [:name, :phone_number])
    |> validate_required([:name, :phone_number])
    |> validate_length(:phone_number, min: 9, max: 13)
  end
end
