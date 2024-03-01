defmodule NikoSafe.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :phone_number])
    |> validate_required([:name, :phone_number])
  end
end
