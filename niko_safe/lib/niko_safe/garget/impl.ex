defmodule NikoSafe.Garget.Impl do
  alias NikoSafe.Repo
  alias NikoSafe.Garget.GargetSchema
  import Ecto.Query

  # get all gargets
  def get_all do

    Repo.all(GargetSchema)
  end

  def insert_garget(garget_attrs) do
    %GargetSchema{}
    |> GargetSchema.changeset(garget_attrs)
    |> Repo.insert()

  end

  def get_garget_by(id) do
    query = from g in GargetSchema,
      where: g.id == ^id,
      select: [g.latitude, g.longitude]  
    Repo.all(query)
  end

  def delete_garget(id) do
    # this will delete the given id
   Repo.delete(GargetSchema, id)

  end

  def update_garget(%GargetSchema{} = garget, attrs) do
    garget
    |> GargetSchema.changeset(attrs)
    |> Repo.update()

  end

 
end
