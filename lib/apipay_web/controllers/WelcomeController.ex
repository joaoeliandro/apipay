defmodule ApipayWeb.WelcomeController do
  use ApipayWeb, :controller

  def index(conn, _params) do
    text(conn, "Hello World!")
  end
end
