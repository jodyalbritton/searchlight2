defmodule Searchlight.Web.BotController do
  use Searchlight.Web, :controller

  alias Searchlight.BotManager

  def index(conn, _params) do
    bots = BotManager.list_bots()
    render(conn, "index.html", bots: bots)
  end

  def new(conn, _params) do
    changeset = BotManager.change_bot(%Searchlight.BotManager.Bot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bot" => bot_params}) do
    case BotManager.create_bot(bot_params) do
      {:ok, bot} ->
        conn
        |> put_flash(:info, "Bot created successfully.")
        |> redirect(to: bot_path(conn, :show, bot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bot = BotManager.get_bot!(id)
    render(conn, "show.html", bot: bot)
  end

  def edit(conn, %{"id" => id}) do
    bot = BotManager.get_bot!(id)
    changeset = BotManager.change_bot(bot)
    render(conn, "edit.html", bot: bot, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bot" => bot_params}) do
    bot = BotManager.get_bot!(id)

    case BotManager.update_bot(bot, bot_params) do
      {:ok, bot} ->
        conn
        |> put_flash(:info, "Bot updated successfully.")
        |> redirect(to: bot_path(conn, :show, bot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bot: bot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bot = BotManager.get_bot!(id)
    {:ok, _bot} = BotManager.delete_bot(bot)

    conn
    |> put_flash(:info, "Bot deleted successfully.")
    |> redirect(to: bot_path(conn, :index))
  end
end
