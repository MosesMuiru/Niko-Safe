defmodule NikoSafe.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:device) do
      add :device_name, :string
      add :device_unique_id, :integer

      #      add :user_id, references(:user)

      timestamps()
    end

    create unique_index(:device, [:device_name, :device_unique_id])
  end
end
