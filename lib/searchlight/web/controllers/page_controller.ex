defmodule Searchlight.Web.PageController do
  use Searchlight.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
