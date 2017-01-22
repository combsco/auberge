defmodule Auberge.Repo.Migrations.AddRoomRatesTable do
  use Ecto.Migration

  def change do
    create table(:room_rates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 30
      add :short_code, :string, size: 10
      add :type, :string, size: 30
      add :starts_at, :date, default: fragment("current_date")
      add :ends_at, :date, default: fragment("current_date + interval '7 day'")
      add :effective_days, :map
      add :min_stay, :integer, default: 1
      add :max_stay, :integer, default: 7
      add :min_occupancy, :integer, default: 1
      add :max_occupancy, :integer, default: 2
      add :extra_adult_price, :decimal, default: 0.00
      add :extra_child_price, :decimal, default: 0.00
      add :price, :decimal, default: 1.00
      add :price_model, :string, size: 30, default: "PerDay"
      add :status, :string, size: 10, default: "active"

      add :created_by, :string, size: 10
      add :updated_by, :string, size: 10
      timestamps(type: :utc_datetime, usec: false, inserted_at: :created_at)
    end

    create index(:room_rates, [:short_code], unique: true)
    create constraint(:room_rates, :starts_before_it_ends, check: "starts_at < ends_at")
  end
end
