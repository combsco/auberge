defmodule Auberge.Repo.Migrations.AddRoomTypesTable do
  use Ecto.Migration

  def up do
    create table(:room_types) do
      add :description, :string, size: 30
      add :num_of_beds, :integer
      add :type_of_beds, :string

      timestamps()
      add :deleted_at, :datetime
    end
  end

  def down do
    drop table(:room_types)
  end
end
