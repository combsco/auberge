defmodule Auberge.Repo.Migrations.AddRoomTypesTable do
  use Ecto.Migration

  def change do
    create table(:room_types) do
      add :description, :string, size: 30
      add :num_of_beds, :integer, default: 1
      add :type_of_beds, :string, default: "Unknown"

      timestamps()
      add :deleted_at, :utc_datetime
    end

    create index(:room_types, [:description, :num_of_beds, :type_of_beds, :deleted_at], unique: true)
  end
end
