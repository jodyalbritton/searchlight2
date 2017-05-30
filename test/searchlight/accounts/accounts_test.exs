defmodule Searchlight.AccountsTest do
  use Searchlight.DataCase

  alias Searchlight.Accounts

  describe "services" do
    alias Searchlight.Accounts.Service

    @valid_attrs %{auth_token: "some auth_token", base_uri: "some base_uri", client_id: "some client_id", client_secret: "some client_secret"}
    @update_attrs %{auth_token: "some updated auth_token", base_uri: "some updated base_uri", client_id: "some updated client_id", client_secret: "some updated client_secret"}
    @invalid_attrs %{auth_token: nil, base_uri: nil, client_id: nil, client_secret: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Accounts.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Accounts.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Accounts.create_service(@valid_attrs)
      assert service.auth_token == "some auth_token"
      assert service.base_uri == "some base_uri"
      assert service.client_id == "some client_id"
      assert service.client_secret == "some client_secret"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, service} = Accounts.update_service(service, @update_attrs)
      assert %Service{} = service
      assert service.auth_token == "some updated auth_token"
      assert service.base_uri == "some updated base_uri"
      assert service.client_id == "some updated client_id"
      assert service.client_secret == "some updated client_secret"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_service(service, @invalid_attrs)
      assert service == Accounts.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Accounts.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Accounts.change_service(service)
    end
  end

  describe "devices" do
    alias Searchlight.Accounts.Device

    @valid_attrs %{capabiltities: %{}, label: "some label", name: "some name"}
    @update_attrs %{capabiltities: %{}, label: "some updated label", name: "some updated name"}
    @invalid_attrs %{capabiltities: nil, label: nil, name: nil}

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_device()

      device
    end

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      assert Accounts.list_devices() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Accounts.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Accounts.create_device(@valid_attrs)
      assert device.capabiltities == %{}
      assert device.label == "some label"
      assert device.name == "some name"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, device} = Accounts.update_device(device, @update_attrs)
      assert %Device{} = device
      assert device.capabiltities == %{}
      assert device.label == "some updated label"
      assert device.name == "some updated name"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_device(device, @invalid_attrs)
      assert device == Accounts.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Accounts.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Accounts.change_device(device)
    end
  end
end
