defmodule NikoSafe.PoliceTeam.Impl do
  alias NikoSafe.Repo
  # use Ecto.Query
  alias NikoSafe.PoliceTeam.PoliceTeam

  def get_all_police do
    # this will get all the police team and the statation
    Repo.all(PoliceTeam)
  end
  
  def insert_police(police_details) do
    %PoliceTeam{}
    |> PoliceTeam.changeset(police_details)
    |> Repo.insert()

  end

  # this is able to get the police either by id or either by police name
  #
  
end
