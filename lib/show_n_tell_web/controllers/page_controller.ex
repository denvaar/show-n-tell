defmodule ShowNTellWeb.PageController do
  use ShowNTellWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
