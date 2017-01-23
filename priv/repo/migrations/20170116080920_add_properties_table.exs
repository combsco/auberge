defmodule Auberge.Repo.Migrations.AddPropertiesTable do
  use Ecto.Migration

  def change do
    create table(:properties, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 30
      add :address, :map
      add :cancellation_time, :string, size: 5
      add :reservation_cutoff, :map
      add :currency, :string, size: 3
      add :tz, :string, size: 254
      add :status, :string, size: 10, default: "active"

      add :created_by, :string, size: 10
      add :updated_by, :string, size: 10
      timestamps(type: :utc_datetime, usec: false, inserted_at: :created_at)
    end

    create index(:properties, [:name], unique: true)
  end
end
