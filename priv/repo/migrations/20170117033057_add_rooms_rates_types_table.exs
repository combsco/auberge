defmodule Auberge.Repo.Migrations.AddRoomsRatesTypesTable do
  use Ecto.Migration

  def change do
    create table(:room_rates_types, primary_key: false) do
      add :room_type_id, references(:room_types)
      add :room_rate_id, references(:room_rates)

      add :inserted_at, :utc_datetime, default: fragment("now()")
    end

    create index(:room_rates_types, [:room_type_id, :room_rate_id], unique: true)
  end
end
