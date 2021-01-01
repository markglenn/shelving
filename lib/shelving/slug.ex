defmodule Shelving.Slug do
  @moduledoc """
  Adds a method to create a slug from an ecto schema.
  """
  import Ecto.Changeset

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

  @spec generate_slug(binary) :: binary
  def generate_slug(title) when is_binary(title) do
    title
    |> String.trim()
    |> String.normalize(:nfd)
    |> String.downcase()
    |> String.replace(~r/[^a-z\s\d-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end

  defp any_changed?(%Ecto.Changeset{} = changeset, fields) do
    all_unchanged =
      fields
      |> Enum.map(&get_change(changeset, &1))
      |> Enum.all?(&is_nil/1)

    !all_unchanged
  end

  defp put_slug(changeset, fields) do
    slug =
      fields
      |> Enum.map(&get_field(changeset, &1))
      |> Enum.join(" ")
      |> generate_slug()

    put_change(changeset, :slug, slug)
  end
end
