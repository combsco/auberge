defmodule Auberge.Repo.Migrations.AddCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :first_name, :string, size: 30
      add :last_name, :string, size: 30
      add :phone_num, :string, size: 15
      add :email, :string, size: 254
      add :address, :map

      timestamps(type: :utc_datetime, usec: false)
      add :deleted_at, :utc_datetime
    end

    create index(:customers, [:email], unique: true, where: "deleted_at is null")
  end
end
