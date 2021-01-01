defmodule Shelving.Factory do
  use ExMachina.Ecto, repo: Shelving.Repo

  def account_factory do
    %Shelving.Accounts.Account{
      name: sequence(:name, &"Account #{&1}"),
      slug: sequence(:slug, &"account-#{&1}")
    }
  end

  def item_factory do
    %Shelving.Inventories.Item{
      name: sequence(:name, &"Item #{&1}"),
      slug: sequence(:slug, &"item-#{&1}"),
      account: build(:account)
    }
  end
end
