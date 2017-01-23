defmodule Auberge.Repo.Migrations.AddCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :first_name, :string, size: 30
      add :last_name, :string, size: 30
      add :phone_num, :string, size: 15
      add :email, :string, size: 254
      add :address, {:array, :map}, default: []

      add :created_by, :string, size: 10
      add :updated_by, :string, size: 10
      timestamps(type: :utc_datetime, usec: false, inserted_at: :created_at)
    end

    create index(:customers, [:email], unique: true)
  end
end
