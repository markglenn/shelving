defmodule Shelving.Products.Sku do
  use Ecto.Schema
  use Shelving.Types.ArchivedAt

  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset
  alias Shelving.Types.Slug
  alias Shelving.Products.Item

  @type t :: %__MODULE__{
          id: pos_integer(),
          manufacturer_sku: String.t(),
          slug: Slug.t(),
          item: Shelving.Products.Item.t(),
          archived_at: NaiveDateTime.t() | nil,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "skus" do
    field :manufacturer_sku, :string
    field :slug, Slug
    belongs_to :item, Shelving.Products.Item

    archivable_timestamp()
    timestamps()
  end

  @doc false
  def changeset(sku, attrs) do
    sku
    |> cast(attrs, [:manufacturer_sku, :archived_at])
    |> Slug.slugify([:manufacturer_sku])
    |> validate_required([:manufacturer_sku, :item_id])
    |> unique_constraint([:item_id, :slug])
    |> foreign_key_constraint(:item_id)
  end

  def for_item(queryable \\ __MODULE__, %Item{id: item_id}) do
    from q in queryable, where: q.item_id == ^item_id
  end
end
