defmodule Shelving.Products.Item do
  use Ecto.Schema
  use Shelving.Types.ArchivedAt

  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Shelving.Types.Slug
  alias Shelving.Accounts.Account

  @type t :: %__MODULE__{
          id: pos_integer(),
          name: String.t(),
          slug: Slug.t(),
          account: Account.t(),
          archived_at: NaiveDateTime.t() | nil,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "items" do
    field :name, :string
    field :slug, Slug
    belongs_to :account, Account

    field :archived_at, :naive_datetime
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:account_id, :name, :archived_at])
    |> Slug.slugify([:name])
    |> validate_required([:account_id, :name])
    |> unique_constraint([:account_id, :slug])
  end

  def changeset(item, %Account{} = account, attrs) do
    item
    |> cast(attrs, [:name, :archived_at])
    |> put_assoc(:account, account)
    |> Slug.slugify([:name])
    |> validate_required([:name])
    |> unique_constraint([:account_id, :slug])
  end

  @spec for_account(Ecto.Queryable.t(), Account.t()) :: Ecto.Query.t()
  def for_account(queryable \\ __MODULE__, %Account{id: account_id}) do
    from q in queryable, where: q.account_id == ^account_id
  end
end
