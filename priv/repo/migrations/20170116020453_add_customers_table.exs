defmodule Auberge.Repo.Migrations.AddCustomersTable do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string, size: 30
      add :last_name, :string, size: 30
      add :phone_num, :string, size: 15
      add :email, :string, size: 254
      add :address, :map

      timestamps()
      add :deleted_at, :datetime
    end
  end
end
