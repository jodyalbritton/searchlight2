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
end
