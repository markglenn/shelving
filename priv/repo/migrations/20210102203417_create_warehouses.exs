defmodule Shelving.Repo.Migrations.CreateWarehouses do
  use Ecto.Migration

  def change do
    create table(:warehouses) do
      add :name, :string, null: false
      add :slug, :string
      add :archived_at, :naive_datetime
      add :account_id, references(:accounts, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:warehouses, [:account_id])
    create index(:warehouses, [:archived_at])
    create unique_index(:warehouses, [:account_id, :slug])
  end
end
