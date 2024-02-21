defmodule NikoSafe.Repo.Migrations.CreateUserRescueTeam do
  use Ecto.Migration

  def change do
    create table(:user_rescue_team) do
      add :police_team_id, references(:police_team, on_delete: :nothing)
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end
  end
end
