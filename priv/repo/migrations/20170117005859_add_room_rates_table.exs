defmodule Auberge.Repo.Migrations.AddRoomRatesTable do
  use Ecto.Migration

  def change do
    create table(:room_rates) do
      add :description, :string, size: 30
      add :code, :string, size: 10
      add :type, :string, size: 30
      add :starts_at, :date, default: fragment("current_date")
      add :ends_at, :date, default: fragment("current_date + interval '7 day'")
      add :days_of_week, :map
      add :min_stay, :integer, default: 1
      add :max_stay, :integer, default: 7
      add :min_occupancy, :integer, default: 1
      add :max_occupancy, :integer, default: 2
      add :extra_adult_price, :float, default: 0.00
      add :extra_child_price, :float, default: 0.00
      add :price, :float, default: 1.00

      timestamps()
      add :deleted_at, :datetime
    end

    create index(:room_rates, [:code], unique: true)
    create constraint(:room_rates, :starts_before_it_ends, check: "starts_at < ends_at")
  end
end
