defmodule Auberge.Repo.Migrations.AddRoomsTable do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :property_id, references(:properties)
      add :room_num, :string, size: 15
      add :floor_num, :integer
      add :room_type_id, references(:room_types)

      timestamps()
      add :deleted_at, :datetime
    end

    create index(:rooms, [:property_id, :room_num, :floor_num, :room_type_id], unique: true)
  end
end
