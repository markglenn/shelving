defmodule Shelving.InventoriesTest do
  use Shelving.DataCase
  import Shelving.Factory

  alias Shelving.Inventories

  describe "items" do
    alias Shelving.Inventories.Item

    @valid_attrs %{archived_at: ~N[2010-04-17 14:00:00], name: "some name"}
    @update_attrs %{archived_at: nil, name: "some updated name"}
    @invalid_attrs %{name: nil}

    setup do
      {:ok, [account: insert(:account)]}
    end

    test "list_items/0 returns all items" do
      item = insert(:item)
      assert Inventories.list_items(item.account) |> Enum.map(& &1.id) == [item.id]
    end

    test "get_item!/1 returns the item with given id" do
      item = insert(:item)
      assert Inventories.get_item!(item.account, item.id).id == item.id
    end

    test "create_item/1 with valid data creates a item", %{account: account} do
      assert {:ok, %Item{} = item} = Inventories.create_item(account, @valid_attrs)
      assert item.archived_at == ~N[2010-04-17 14:00:00]
      assert item.name == "some name"
      assert item.slug == nil
    end

    test "create_item/1 with invalid data returns error changeset", %{account: account} do
      assert {:error, %Ecto.Changeset{}} = Inventories.create_item(account, @invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = insert(:item)
      assert {:ok, %Item{} = item} = Inventories.update_item(item, @update_attrs)
      assert item.archived_at == nil
      assert item.name == "some updated name"
      assert item.slug == "some-updated-name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = insert(:item)
      assert {:error, %Ecto.Changeset{}} = Inventories.update_item(item, @invalid_attrs)
      assert item == Inventories.get_item!(item.id) |> Repo.preload(:account)
    end

    test "delete_item/1 deletes the item" do
      item = insert(:item)
      assert {:ok, %Item{}} = Inventories.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventories.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = insert(:item)
      assert %Ecto.Changeset{} = Inventories.change_item(item)
    end
  end
end
