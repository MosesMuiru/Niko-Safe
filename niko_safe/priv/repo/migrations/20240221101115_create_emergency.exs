defmodule NikoSafe.Repo.Migrations.CreateEmergency do
  use Ecto.Migration

  def change do
    create table("emergency") do
      add :distress_message, :string, default: "i need help"

      timestamps()
    end
  end
end
