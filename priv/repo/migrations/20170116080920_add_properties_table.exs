defmodule Auberge.Repo.Migrations.AddPropertiesTable do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :name, :string, size: 30
      add :address, :map

      timestamps()
      add :deleted_at, :utc_datetime
    end
  end
end
