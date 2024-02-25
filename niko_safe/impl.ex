defmodule NikoSafe.Emergency.Impl do
  alias NikoSafe.Repo
  alias NikoSafe.Emergency.EmergencySchema
  # able to list all emergencies

  def get_all do
    Repo.all(EmergencySchema)
  end

  # getting an Emergency 
  #
end
