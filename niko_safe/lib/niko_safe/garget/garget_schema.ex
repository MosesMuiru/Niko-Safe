defmodule NikoSafe.Garget.GargetSchema do
  use Ecto.Schema
  alias NikoSafe.User.UserSchema
  import Ecto.Changeset

  @optional_fields [:id, :inserted_at, :updated_at, :user_id]
  schema "garget" do
    field :name, :string
    field :longitude, :string
    field :latitude, :string

    timestamps()
    belongs_to :user, UserSchema, foreign_key: :user_id
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
    
  end
  def changeset(garget, params \\ %{}) do
    garget
    |> cast(params, all_fields() -- @optional_fields)
    |> validate_required(all_fields() -- @optional_fields)
    |> unique_constraint([:name])
  end
end
