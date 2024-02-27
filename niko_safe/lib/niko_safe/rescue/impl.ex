defmodule NikoSafe.Rescue.Impl do
  import Ecto.Changeset
  alias NikoSafe.Repo
  alias NikoSafe.Rescue.RescueTeam

  @doc """
    get all contact list in the database

    get a contact list based on the id or name

    able to edit use

  create
    rescue list
  
  read
    all rescue list
    a person based on the 

  update
    change the message
    change user name
    

  """
 
  def get_all do

    Repo.all(RescueTeam)
  end

  def get_by(id) do
    RescueTeam
    |> Repo.get!(id)
  end

  def create_rescue_team(attrs \\ {}) do
    %RescueTeam{}
    |> RescueTeam.changeset(attrs)
    |> Repo.insert()
    

  end

  
  # this will be used to update the user ---> this is including even the changesj
  def update_rescue_team(id, attrs) do

    RescueTeam
    |> Repo.get!(id)
    |> change(attrs)
    |> Repo.update()
    

  end
  


  def delete_rescue_team(%RescueTeam{} = rescue_team, attrs \\ %{}) do

    Repo.delete(rescue_team)
  end

end
