defmodule NikoSafe.Garget.GargetSchema do
  use Ecto.Schema
  use Ecto.Changeset

  schema "garget" do
    field :longitude, :string
    field :latitude, :string


     belongs_to :user, NikoSafe.User.UserSchema
  end
end
