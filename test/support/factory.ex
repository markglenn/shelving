defmodule Shelving.Factory do
  use ExMachina.Ecto, repo: Shelving.Repo

  def account_factory do
    %Shelving.Accounts.Account{
      name: sequence(:name, &"Account #{&1}"),
      slug: sequence(:slug, &"account-#{&1}")
    }
  end

  def item_factory do
    %Shelving.Products.Item{
      name: sequence(:name, &"Item #{&1}"),
      slug: sequence(:slug, &"item-#{&1}"),
      account: build(:account)
    }
  end

  def sku_factory do
    %Shelving.Products.Sku{
      item: build(:item),
      manufacturer_sku: sequence(:manufacturer_sku, &"Manufacturer SKU #{&1}"),
      slug: sequence(:slug, &"manufacturer-sku-#{&1}")
    }
  end
end
