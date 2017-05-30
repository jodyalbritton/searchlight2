defmodule Searchlight.Web.TestController do
  use Searchlight.Web, :controller

  alias Searchlight.TestManager

  def index(conn, _params) do
    tests = TestManager.list_tests()
    render(conn, "index.html", tests: tests)
  end

  def new(conn, _params) do
    changeset = TestManager.change_test(%Searchlight.TestManager.Test{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"test" => test_params}) do
    case TestManager.create_test(test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test created successfully.")
        |> redirect(to: test_path(conn, :show, test))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test = TestManager.get_test!(id)
    render(conn, "show.html", test: test)
  end

  def edit(conn, %{"id" => id}) do
    test = TestManager.get_test!(id)
    changeset = TestManager.change_test(test)
    render(conn, "edit.html", test: test, changeset: changeset)
  end

  def update(conn, %{"id" => id, "test" => test_params}) do
    test = TestManager.get_test!(id)

    case TestManager.update_test(test, test_params) do
      {:ok, test} ->
        conn
        |> put_flash(:info, "Test updated successfully.")
        |> redirect(to: test_path(conn, :show, test))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", test: test, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test = TestManager.get_test!(id)
    {:ok, _test} = TestManager.delete_test(test)

    conn
    |> put_flash(:info, "Test deleted successfully.")
    |> redirect(to: test_path(conn, :index))
  end
end
