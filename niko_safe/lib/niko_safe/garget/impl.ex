defmodule NikoSafe.Garget.Impl do
  alias NikoSafe.Repo
  alias NikoSafe.Garget.GargetSchema
  import Ecto.Query
  alias Ecto.Changeset

  @type t :: list(GargetSchema.t())
  # get all gargets
  @spec get_all() :: t
  def get_all do

    Repo.all(GargetSchema)
  end

  @type g_attrs :: %{ name: String.t(), longitude: String.t(), latitude: String.t(), user_id: integer | nil}
  @spec insert_garget(g_attrs) :: GargetSchema.t()
  def insert_garget(garget_attrs) do
    %GargetSchema{}
    |> GargetSchema.changeset(garget_attrs)
    |> Repo.insert()

  end

  @spec get_garget_by(integer) :: GargetSchema.t()
  def get_garget_by(id) do
    query = from g in GargetSchema,
      where: g.id == ^id,
      select: [g.latitude, g.longitude]  
    Repo.all(query)
  end

  @spec delete_garget(integer) :: nil
  def delete_garget(id) do
    # this will delete the given id
   Repo.delete(GargetSchema, id)

  end

  @spec update_garget(GargetSchema.t(), nil | map) :: GargetSchema.t()
  def update_garget(%GargetSchema{} = garget, attrs) do
    garget
    |> GargetSchema.changeset(attrs)
    |> Repo.update()

  end
  
  def update_garget(garget_id, attrs) do
    GargetSchema
    |> Repo.get!(garget_id)
    |> Changeset.change(attrs)
    |> Repo.update()
  end
 
end
