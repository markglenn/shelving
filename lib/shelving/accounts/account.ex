defmodule Shelving.Accounts.Account do
  use Ecto.Schema
  use Shelving.Archive

  alias Shelving.Slug

  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: pos_integer(),
          name: String.t(),
          slug: String.t() | nil,
          archived_at: NaiveDateTime.t() | nil,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "accounts" do
    field :name, :string
    field :slug, :string

    field :archived_at, :naive_datetime
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
