defmodule NikoSafe.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :phone_number, :string
      add :device_id, references(:device, on_delete: :delete_all)

      timestamps()
    end
  end
end
