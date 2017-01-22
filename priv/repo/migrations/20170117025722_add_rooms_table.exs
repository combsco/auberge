defmodule Auberge.Repo.Migrations.AddRoomsTable do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :property_id, references(:properties, on_delete: :delete_all, type: :uuid)
      add :room_num, :string, size: 15
      add :floor_num, :integer
      add :size_sqm, :decimal
      add :cta, :map
      add :ctd, :map
      add :status, :string, size: 10, default: "active"

      add :room_type_id, references(:room_types, on_delete: :nothing, type: :uuid)

      add :created_by, :string, size: 10
      add :updated_by, :string, size: 10
      timestamps(type: :utc_datetime, usec: false, inserted_at: :created_at)
    end

    create index(:rooms, [:property_id, :room_num, :floor_num], unique: true)
  end
end
