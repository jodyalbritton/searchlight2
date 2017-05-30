
defmodule Searchlight.Web.Session do
  @moduledoc """
  Session Helper
  """
  alias Searchlight.Accounts

  def authenticate(%{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email(email)

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _ -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
  end
end
