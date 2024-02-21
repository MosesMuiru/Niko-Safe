defmodule NikoSafe.Garget.GargetSchema do
  use Ecto.Schema
  alias NikoSafe.User.UserSchema
  import Ecto.Changeset

  schema "garget" do
    field :name, :string
    field :longitude, :string
    field :latitude, :string

    timestamps()
    belongs_to :user, UserSchema, foreign_key: :user_id
  end

  def changeset(garget, params \\ %{}) do
    garget
    |> cast(params, [:name, :longitude, :latitude])
    |> validate_required([:name, :longitide, :latitude])
    |> unique_constraint([:name])
  
  end
end
