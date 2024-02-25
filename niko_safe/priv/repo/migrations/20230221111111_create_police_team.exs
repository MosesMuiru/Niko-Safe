defmodule NikoSafe.Repo.Migrations.CreatePoliceTeam do
  use Ecto.Migration

  def change do
    create table(:police_team) do
      add :phone_number, :string
      add :station_name, :string

      timestamps()
    end
  end
end
