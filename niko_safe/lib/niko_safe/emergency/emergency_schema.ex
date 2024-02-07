defmodule NikoSafe.Emergency.EmergencySchema do
  use Ecto.Schema
  use Ecto.Changeset

  alias NikoSafe.User.UserSchema

  schema "emergency" do
    field :health, :string
    field :tragedy, :string

    belongs_to :user, UserSchema
  end

end
