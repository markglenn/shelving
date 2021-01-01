defmodule Shelving.Inventories.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :slug, :string
    belongs_to :account, Shelving.Accounts.Account

    field :archived_at, :naive_datetime
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :slug, :archived_at])
    |> validate_required([:name, :slug, :archived_at])
  end
end
