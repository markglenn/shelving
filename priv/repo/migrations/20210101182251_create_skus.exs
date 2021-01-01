defmodule Shelving.Repo.Migrations.CreateSkus do
  use Ecto.Migration

  def change do
    create table(:skus) do
      add :manufacturer_sku, :string, null: false
      add :item_id, references(:items, on_delete: :delete_all), null: false
      add :slug, :string
      add :archived_at, :naive_datetime

      timestamps()
    end

    create index(:skus, [:manufacturer_sku])
    create index(:skus, [:item_id])
    create index(:skus, [:archived_at])
    create unique_index(:skus, [:item_id, :slug])
  end
end
