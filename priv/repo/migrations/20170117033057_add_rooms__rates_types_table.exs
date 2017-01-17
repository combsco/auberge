defmodule Auberge.Repo.Migrations.AddRoomsRatesTypesTable do
  use Ecto.Migration

  def up do
    create table(:room_rates_types) do
      add :room_type_id, references(:room_types)
      add :room_rate_id, references(:room_rates)

      timestamps()
      add :deleted_at, :datetime
    end
  end

  def down do
    drop table(:room_rates_types)
  end
end
