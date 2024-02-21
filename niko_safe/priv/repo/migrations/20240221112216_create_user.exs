defmodule NikoSafe.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :phone_number, :string
      add :garget_id, references(:garget, on_delete: :nothing)
      add :police_team_id, references(:police_team, on_delete: :nothing)
      add :emergency_id, references(:emergency, on_delete: :nothing)

      timestamps()
    end
  end
end
