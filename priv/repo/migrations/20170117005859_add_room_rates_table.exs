defmodule Auberge.Repo.Migrations.AddRoomRatesTable do
  use Ecto.Migration

  def up do
    create table(:room_rates) do
      add :description, :string, size: 30
      add :code, :string, size: 10
      add :type, :string, size: 30
      add :starts_at, :datetime
      add :ends_at, :datetime
      add :days_of_week, :map
      add :min_stay, :integer
      add :max_stay, :integer
      add :min_occupancy, :integer
      add :max_occupancy, :integer
      add :extra_adult_price, :float
      add :extra_child_price, :float
      add :price, :float

      timestamps()
      add :deleted_at, :datetime
    end
  end

  def down do
    drop table(:room_rates)
  end
end
