defmodule NikoSafe.Garget.GargetSchema do
  use Ecto.Schema
  alias NikoSafe.User.UserSchema

  schema "garget" do
    field :name, :string
    field :longitude, :string
    field :latitude, :string

    timestamps()
    belongs_to :user, UserSchema, foreign_key: :user_id
  end
end
