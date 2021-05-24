defmodule Apipay.Accounts.TransactionService do
  alias Ecto.Multi

  alias Apipay.Accounts.OperationUtil, as: Operation
  alias Apipay.{Repo, Transaction}

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    params = %{from_id: from_id, to_id: to_id, value: value}

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> Multi.insert(:create_transaction, Transaction.changeset(params))
    |> Multi.run(:preload_data, fn repo, %{create_transaction: transaction} ->
      preload_data(repo, transaction)
    end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp preload_data(repo, transaction) do
    {:ok, repo.preload(transaction, [:from, :to])}
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
