defmodule Auberge.Repo.Migrations.AddRoomTypesTable do
  use Ecto.Migration

  def change do
    create table(:room_types, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string, size: 30
      add :class, :string, size: 30
      add :view, :string, size: 30
      add :max_adults, :integer, default: 2
      add :max_children, :integer, default: 2
      add :bedding, :map
      add :extra_bedding, {:array, :map}, default: []
      add :smoking, :boolean, default: false
      add :status, :string, size: 10, default: "active"

      add :created_by, :string, size: 10
      add :updated_by, :string, size: 10
      timestamps(type: :utc_datetime, usec: false, inserted_at: :created_at)
    end
  end
end
