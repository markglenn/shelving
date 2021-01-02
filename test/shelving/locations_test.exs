defmodule Shelving.LocationsTest do
  use Shelving.DataCase
  import Shelving.Factory

  alias Shelving.Locations

  describe "warehouses" do
    alias Shelving.Locations.Warehouse

    @valid_attrs %{archived_at: ~N[2010-04-17 14:00:00], name: "some name"}
    @update_attrs %{archived_at: nil, name: "some updated name"}
    @invalid_attrs %{archived_at: nil, name: nil}

    test "list_warehouses/0 returns all warehouses" do
      warehouse = insert(:warehouse)
      assert Locations.list_warehouses(warehouse.account) |> Enum.map(& &1.id) == [warehouse.id]
    end

    test "get_warehouse!/2 returns the warehouse with given id" do
      warehouse = insert(:warehouse)
      assert Locations.get_warehouse!(warehouse.account, warehouse.slug).id == warehouse.id
    end

    test "create_warehouse/1 with valid data creates a warehouse" do
      account = insert(:account)

      assert {:ok, %Warehouse{} = warehouse} =
               Locations.create_warehouse(@valid_attrs, for: account)

      assert warehouse.archived_at == ~N[2010-04-17 14:00:00]
      assert warehouse.name == "some name"
      assert warehouse.slug == nil
    end

    test "create_warehouse/1 with invalid data returns error changeset" do
      account = insert(:account)

      assert {:error, %Ecto.Changeset{}} =
               Locations.create_warehouse(@invalid_attrs, for: account)
    end

    test "update_warehouse/2 with valid data updates the warehouse" do
      warehouse = insert(:warehouse)

      assert {:ok, %Warehouse{} = warehouse} =
               Locations.update_warehouse(warehouse, @update_attrs)

      assert warehouse.archived_at == nil
      assert warehouse.name == "some updated name"
      assert warehouse.slug == "some-updated-name"
    end

    test "update_warehouse/2 with invalid data returns error changeset" do
      warehouse = insert(:warehouse)
      assert {:error, %Ecto.Changeset{}} = Locations.update_warehouse(warehouse, @invalid_attrs)
      assert warehouse.name == Locations.get_warehouse!(warehouse.account, warehouse.slug).name
    end

    test "delete_warehouse/1 deletes the warehouse" do
      warehouse = insert(:warehouse)
      assert {:ok, %Warehouse{}} = Locations.delete_warehouse(warehouse)

      assert_raise Ecto.NoResultsError, fn ->
        Locations.get_warehouse!(warehouse.account, warehouse.slug)
      end
    end

    test "change_warehouse/1 returns a warehouse changeset" do
      warehouse = insert(:warehouse)
      assert %Ecto.Changeset{} = Locations.change_warehouse(warehouse)
    end
  end
end
