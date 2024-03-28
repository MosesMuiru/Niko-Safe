defmodule NikoSafe.User.Users do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :phone_number, :string
    field :unique_key, :integer

    timestamps()
  
  end

  def changeset(users, params \\ %{}) do

    users
    |> cast(params, [:name, :phone_number, :unique_key])
    |> validate_required([:name, :phone_number, :unique_key])
    |> validate_length(:phone_number, min: 10, max: 14)
    
  end


end
