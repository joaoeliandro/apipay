defmodule ApipayWeb.AccountsView do
  alias Apipay.{Account, Transaction}

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance updated successfully!",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
        transaction: %Transaction{
          id: transaction_id,
          to: to_account,
          from: from_account,
          value: value
        }
      }) do
    %{
      message: "Transaction done successfully!",
      transaction: %{
        id: transaction_id,
        from: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to: %{
          id: to_account.id,
          balance: to_account.balance
        },
        value: value
      }
    }
  end
end
