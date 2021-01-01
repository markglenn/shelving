defmodule Shelving.ProductsTest do
  use Shelving.DataCase
  import Shelving.Factory

  alias Shelving.Products

  describe "items" do
    alias Shelving.Products.Item

    @valid_attrs %{archived_at: ~N[2010-04-17 14:00:00], name: "some name"}
    @update_attrs %{archived_at: nil, name: "some updated name"}
    @invalid_attrs %{name: nil}

    setup do
      {:ok, [account: insert(:account)]}
    end

    test "list_items/0 returns all items" do
      item = insert(:item)
      assert Products.list_items(item.account) |> Enum.map(& &1.id) == [item.id]
    end

    test "get_item!/1 returns the item with given id" do
      item = insert(:item)
      assert Products.get_item!(item.account, item.id).id == item.id
    end

    test "create_item/1 with valid data creates a item", %{account: account} do
      assert {:ok, %Item{} = item} = Products.create_item(account, @valid_attrs)
      assert item.archived_at == ~N[2010-04-17 14:00:00]
      assert item.name == "some name"
      assert item.slug == nil
    end

    test "create_item/1 with invalid data returns error changeset", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = Products.create_item(account, @invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = insert(:item)
      assert {:ok, %Item{} = item} = Products.update_item(item, @update_attrs)
      assert item.archived_at == nil
      assert item.name == "some updated name"
      assert item.slug == "some-updated-name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = insert(:item)
      assert {:error, %Ecto.Changeset{}} = Products.update_item(item, @invalid_attrs)
      assert item == Products.get_item!(item.account, item.id) |> Repo.preload(:account)
    end

    test "delete_item/1 deletes the item" do
      item = insert(:item)
      assert {:ok, %Item{}} = Products.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Products.get_item!(item.account, item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = insert(:item)
      assert %Ecto.Changeset{} = Products.change_item(item)
    end
  end

  describe "skus" do
    alias Shelving.Products.Sku

    @valid_attrs %{manufacturer_sku: "some sku"}
    @update_attrs %{
      archived_at: ~N[2011-05-18 15:01:01],
      manufacturer_sku: "some updated sku"
    }
    @invalid_attrs %{manufacturer_sku: nil}

    test "list_skus/0 returns all skus" do
      sku = insert(:sku)
      assert Products.list_skus(sku.item) |> Enum.map(& &1.id) == [sku.id]
    end

    test "get_sku!/1 returns the sku with given id" do
      sku = insert(:sku)
      assert Products.get_sku!(sku.item, sku.id).id == sku.id
    end

    test "create_sku/1 with valid data creates a sku" do
      assert {:ok, %Sku{} = sku} = Products.create_sku(insert(:item), @valid_attrs)
      assert sku.archived_at == nil
      assert sku.manufacturer_sku == "some sku"
      assert sku.slug == "some-sku"
    end

    test "create_sku/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_sku(insert(:item), @invalid_attrs)
    end

    test "update_sku/2 with valid data updates the sku" do
      sku = insert(:sku)
      assert {:ok, %Sku{} = sku} = Products.update_sku(sku, @update_attrs)
      assert sku.archived_at == ~N[2011-05-18 15:01:01]
      assert sku.manufacturer_sku == "some updated sku"
      assert sku.slug == nil
    end

    test "update_sku/2 with invalid data returns error changeset" do
      sku = insert(:sku)
      assert {:error, %Ecto.Changeset{}} = Products.update_sku(sku, @invalid_attrs)
    end

    test "delete_sku/1 deletes the sku" do
      sku = insert(:sku)
      assert {:ok, %Sku{}} = Products.delete_sku(sku)
      assert_raise Ecto.NoResultsError, fn -> Products.get_sku!(sku.item, sku.id) end
    end

    test "change_sku/1 returns a sku changeset" do
      sku = insert(:sku)
      assert %Ecto.Changeset{} = Products.change_sku(sku)
    end
  end
end
