defmodule NikoSafe.Repo.Migrations.CreateGarget do
  use Ecto.Migration

  def change do
    create table(:garget) do
      add :name, :string
      add :longitude, :string
      add :latitude, :string

      timestamps()
    end
  end
end
