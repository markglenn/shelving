defmodule Shelving.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias Shelving.Repo

  alias Shelving.Accounts.Account
  alias Shelving.Locations.Warehouse

  @doc """
  Returns the list of warehouses.

  ## Examples

      iex> list_warehouses()
      [%Warehouse{}, ...]

  """
  def list_warehouses(%Account{} = account) do
    Warehouse
    |> Warehouse.unarchived()
    |> Warehouse.for_account(account)
    |> Repo.all()
  end

  @doc """
  Gets a single warehouse.

  Raises `Ecto.NoResultsError` if the Warehouse does not exist.

  ## Examples

      iex> get_warehouse!(123)
      %Warehouse{}

      iex> get_warehouse!(456)
      ** (Ecto.NoResultsError)

  """
  def get_warehouse!(%Account{} = account, slug) do
    Warehouse
    |> Warehouse.unarchived()
    |> Warehouse.for_account(account)
    |> Repo.get_by!(slug: slug)
  end

  @doc """
  Creates a warehouse.

  ## Examples

      iex> create_warehouse(%{field: value})
      {:ok, %Warehouse{}}

      iex> create_warehouse(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_warehouse(attrs \\ %{}, for: %Account{id: account_id}) do
    %Warehouse{account_id: account_id}
    |> Warehouse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a warehouse.

  ## Examples

      iex> update_warehouse(warehouse, %{field: new_value})
      {:ok, %Warehouse{}}

      iex> update_warehouse(warehouse, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_warehouse(%Warehouse{} = warehouse, attrs) do
    warehouse
    |> Warehouse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a warehouse.

  ## Examples

      iex> delete_warehouse(warehouse)
      {:ok, %Warehouse{}}

      iex> delete_warehouse(warehouse)
      {:error, %Ecto.Changeset{}}

  """
  def delete_warehouse(%Warehouse{} = warehouse) do
    Repo.archive(warehouse)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking warehouse changes.

  ## Examples

      iex> change_warehouse(warehouse)
      %Ecto.Changeset{data: %Warehouse{}}

  """
  def change_warehouse(%Warehouse{} = warehouse, attrs \\ %{}) do
    Warehouse.changeset(warehouse, attrs)
  end
end
