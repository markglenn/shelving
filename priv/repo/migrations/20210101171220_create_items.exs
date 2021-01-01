defmodule Shelving.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :slug, :string
      add :archived_at, :naive_datetime
      add :account_id, references(:accounts, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:items, [:account_id])
    create index(:items, [:archived_at])
    create unique_index(:items, [:account_id, :slug])
  end
end
