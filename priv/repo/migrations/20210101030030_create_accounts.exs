defmodule Shelving.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string, null: false
      add :slug, :string
      add :archived_at, :naive_datetime

      timestamps()
    end

    create index(:accounts, [:archived_at])
    create unique_index(:accounts, [:name])
    create unique_index(:accounts, [:slug])
  end
end
