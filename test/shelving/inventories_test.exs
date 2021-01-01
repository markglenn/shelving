defmodule Shelving.InventoriesTest do
  use Shelving.DataCase

  alias Shelving.Inventories

  describe "items" do
    alias Shelving.Inventories.Item

    @valid_attrs %{archived_at: ~N[2010-04-17 14:00:00], name: "some name", slug: "some slug"}
    @update_attrs %{archived_at: ~N[2011-05-18 15:01:01], name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{archived_at: nil, name: nil, slug: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventories.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Inventories.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventories.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Inventories.create_item(@valid_attrs)
      assert item.archived_at == ~N[2010-04-17 14:00:00]
      assert item.name == "some name"
      assert item.slug == "some slug"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventories.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Inventories.update_item(item, @update_attrs)
      assert item.archived_at == ~N[2011-05-18 15:01:01]
      assert item.name == "some updated name"
      assert item.slug == "some updated slug"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventories.update_item(item, @invalid_attrs)
      assert item == Inventories.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventories.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventories.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventories.change_item(item)
    end
  end
end
