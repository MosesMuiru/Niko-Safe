defmodule NikoSafe.Garget.Impl.ex() do
  alias NikoSafe.Garget.GargetSchema
  alias NikoSafe.Repo

  def get_all_garget do
    Repo.all(GargetSchema)
  end
end
