defmodule ApipayWeb.UsersController do
  use ApipayWeb, :controller

  alias Apipay.User

  action_fallback ApipayWeb.FallbackController

  def create(conn, params) do
    params
    |> Apipay.create_user()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end

  defp handle_response({:error, _result} = error, _conn), do: error
end
