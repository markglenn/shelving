defmodule Shelving.Accounts do
  alias Shelving.Accounts.Account
  alias Shelving.Repo

  @spec get_account(String.t()) :: Account.t() | nil
  def get_account(slug) do
    Repo.get_by(Account.unarchived(), slug: slug)
  end

  @doc """
  Creates a account.
  ## Examples
      iex> create_account(%{field: value})
      {:ok, %Account{}}
      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
