defmodule Shelving.Locations.Warehouse do
  use Ecto.Schema
  use Shelving.Types.ArchivedAt

  import Ecto.Changeset
  import Ecto.Query, only: [where: 3]

  alias Shelving.Accounts.Account
  alias Shelving.Types.Slug

  @type t :: %__MODULE__{
          id: pos_integer(),
          name: String.t(),
          slug: String.t() | nil,
          account: Account.t(),
          account_id: pos_integer(),
          archived_at: NaiveDateTime.t() | nil,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "warehouses" do
    field :name, :string
    field :slug, :string
    belongs_to :account, Account

    archivable_timestamp()
    timestamps()
  end

  @doc false
  def changeset(warehouse, attrs) do
    warehouse
    |> cast(attrs, [:name, :archived_at])
    |> validate_required([:name])
    |> Slug.slugify([:name])
    |> unique_constraint([:account_id, :slug])
    |> foreign_key_constraint(:account_id)
  end

  def for_account(queryable \\ __MODULE__, %Account{id: account_id}),
    do: where(queryable, [q], q.account_id == ^account_id)
end
