defmodule Auberge.Repo.Migrations.AddDeletedAtToCustomers do
  use Ecto.Migration

  def change do
    alter table(:customers) do
      add :deleted_at, :datetime
    end
  end
end
