defmodule Shelving.Slug do
  use Ecto.Type

  @moduledoc """
  Adds a method to create a slug from an ecto schema.
  """
  import Ecto.Changeset

  @type t :: String.t() | nil
  def type, do: :string

  @spec slugify(Ecto.Changeset.t(), atom | [atom]) :: Ecto.Changeset.t()
  @doc """
  Set the slug for an ecto model given a field (or list of fields).

      record
      |> cast(attrs, [:name, :slug, :archived_at])
      |> Slug.slugify(:name)

  If the model is archived, it sets the slug to nil in the changeset.
  """
  def slugify(%Ecto.Changeset{} = changeset, fields) when is_list(fields) do
    cond do
      get_field(changeset, :archived_at) != nil ->
        put_change(changeset, :slug, nil)

      any_changed?(changeset, fields) ->
        put_slug(changeset, fields)

      true ->
        changeset
    end
  end

  def slugify(%Ecto.Changeset{} = changeset, field), do: slugify(changeset, [field])

  @spec generate_slug(String.t()) :: String.t()
  @doc """
  Generate a slug from a string

      iex> generate_slug("This is a test")

      "this-is-a-test"
  """
  def generate_slug(str) when is_binary(str) do
    str
    |> String.trim()
    |> String.normalize(:nfd)
    |> String.downcase()
    |> String.replace(~r/[^a-z\s\d-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end

  # Determines if any of the given fields are dirty
  defp any_changed?(%Ecto.Changeset{} = changeset, fields) do
    fields
    |> Enum.any?(fn field -> get_change(changeset, field) != nil end)
  end

  # Put the slug into the changeset as "slug"
  defp put_slug(changeset, fields) do
    slug =
      fields
      |> Enum.map(&get_field(changeset, &1))
      |> Enum.join(" ")
      |> generate_slug()

    put_change(changeset, :slug, slug)
  end

  def cast(slug) when is_binary(slug), do: {:ok, slug}
  def cast(nil), do: {:ok, nil}

  # Everything else is a failure though
  def cast(_), do: :error

  def load(data) when is_binary(data), do: {:ok, data}
  def load(nil), do: {:ok, nil}

  def dump(slug) when is_binary(slug), do: {:ok, slug}
  def dump(nil), do: {:ok, nil}
  def dump(_), do: :error
end
