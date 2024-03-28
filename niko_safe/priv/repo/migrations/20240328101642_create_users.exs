defmodule NikoSafe.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do

    create table(:users) do
      
        add :name, :string
        add :phone_number, :string
        add :unique_key, :integer
        add :device_id, references(:device)

      timestamps()

    
    end
  end
end
