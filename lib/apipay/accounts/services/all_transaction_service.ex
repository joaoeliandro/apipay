defmodule Apipay.Accounts.AllTransactionService do
  import Ecto.Query

  alias Ecto.Multi

  alias Apipay.{Repo, Transaction}

  def call() do
    Multi.new()
    |> Multi.run(:list_transactions, fn repo, _changes -> find_all_transactions(repo) end)
    |> Multi.run(:preload_data, fn repo, %{list_transactions: transactions} ->
      preload_data(repo, transactions)
    end)
    |> run_transaction()
  end

  defp find_all_transactions(repo) do
    list_transactions =
      Transaction
      |> select([t], t)
      |> repo.all()

    List.to_tuple([:ok, list_transactions])
  end

  defp preload_data(repo, transactions) do
    {:ok, repo.preload(transactions, [:from, :to])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: transaction}} ->
        {:ok, transaction}
    end
  end
end
