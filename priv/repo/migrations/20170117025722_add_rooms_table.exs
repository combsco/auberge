defmodule Auberge.Repo.Migrations.AddRoomsTable do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :property_id, references(:properties, on_delete: :delete_all, type: :uuid)
      add :room_num, :string, size: 15
      add :floor_num, :integer
      add :room_type_id, references(:room_types, on_delete: :nothing, type: :uuid)

      timestamps()
      add :deleted_at, :utc_datetime
    end

    create index(:rooms, [:property_id, :room_num, :floor_num, :room_type_id], unique: true)
  end
end
