defmodule Shelving.Accounts.Account do
  use Ecto.Schema
  use Shelving.ArchivedAt

  alias Shelving.Slug

  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: pos_integer(),
          name: String.t(),
          slug: Slug.t(),
          archived_at: ArchivedAt.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "accounts" do
    field :name, :string
    field :slug, Slug

    field :archived_at, ArchivedAt.type()
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :archived_at])
    |> Slug.slugify([:name])
    |> validate_required([:name])
  end
end
