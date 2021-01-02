defmodule Shelving.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Shelving.Repo

  alias Shelving.Products.Item
  alias Shelving.Accounts.Account

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items(%Account{} = account) do
    Item
    |> Item.unarchived()
    |> Item.for_account(account)
    |> Repo.all()
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(%Account{} = account, id) do
    Item
    |> Item.unarchived()
    |> Item.for_account(account)
    |> Repo.get!(id)
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}, for: %Account{id: account_id}) do
    %Item{account_id: account_id}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.archive(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  alias Shelving.Products.Sku

  @doc """
  Returns the list of skus.

  ## Examples

      iex> list_skus()
      [%Sku{}, ...]

  """
  def list_skus(%Item{} = item) do
    Sku
    |> Sku.unarchived()
    |> Sku.for_item(item)
    |> Repo.all()
  end

  @doc """
  Gets a single sku.

  Raises `Ecto.NoResultsError` if the Sku does not exist.

  ## Examples

      iex> get_sku!(123)
      %Sku{}

      iex> get_sku!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sku!(%Item{} = item, id) do
    Sku
    |> Sku.unarchived()
    |> Sku.for_item(item)
    |> Repo.get!(id)
  end

  @doc """
  Creates a sku.

  ## Examples

      iex> create_sku(%{field: value})
      {:ok, %Sku{}}

      iex> create_sku(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sku(attrs \\ %{}, for: %Item{id: item_id}) do
    %Sku{item_id: item_id}
    |> Sku.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sku.

  ## Examples

      iex> update_sku(sku, %{field: new_value})
      {:ok, %Sku{}}

      iex> update_sku(sku, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sku(%Sku{} = sku, attrs) do
    sku
    |> Sku.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sku.

  ## Examples

      iex> delete_sku(sku)
      {:ok, %Sku{}}

      iex> delete_sku(sku)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sku(%Sku{} = sku) do
    Repo.delete(sku)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sku changes.

  ## Examples

      iex> change_sku(sku)
      %Ecto.Changeset{data: %Sku{}}

  """
  def change_sku(%Sku{} = sku, attrs \\ %{}) do
    Sku.changeset(sku, attrs)
  end
end
