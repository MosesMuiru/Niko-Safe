defmodule NikoSafe.Repo.Migrations.CreateRescueTeam do
  use Ecto.Migration

  def change do
    create table(:rescue_team) do
      add :name, :string
      add :phone_number, :string
      add :message, :string
      add :user_id, references(:user, on_delete: :delete_all)
    end
  end
end
