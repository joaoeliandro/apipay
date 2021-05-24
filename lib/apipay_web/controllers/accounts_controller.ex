defmodule ApipayWeb.AccountsController do
  use ApipayWeb, :controller

  alias Apipay.{Account, Transaction}

  action_fallback ApipayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Apipay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Apipay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %Transaction{} = transaction} <- Apipay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
