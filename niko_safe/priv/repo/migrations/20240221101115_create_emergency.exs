defmodule NikoSafe.Repo.Migrations.CreateEmergency do
  use Ecto.Migration

  def change do
    create table("emergency") do
      add :health, :string
      add :tragedy, :string

      timestamps()
    end
  end
end
