defmodule Auberge.Repo.Migrations.AddRoomsRatesTypesTable do
  use Ecto.Migration

  def change do
    create table(:room_rates_types, primary_key: false) do
      add :room_type_id, references(:room_types, on_delete: :delete_all, type: :uuid)
      add :room_rate_id, references(:room_rates, on_delete: :delete_all, type: :uuid)

      add :inserted_at, :utc_datetime, default: fragment("now()")
    end

    create index(:room_rates_types, [:room_type_id, :room_rate_id], unique: true)
  end
end
