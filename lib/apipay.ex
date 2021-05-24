defmodule Apipay do
  alias Apipay.Users.Create, as: UserCreate

  alias Apipay.Accounts.{DepositService, TransactionService, WithdrawService}

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: DepositService, as: :call
  defdelegate withdraw(params), to: WithdrawService, as: :call
  defdelegate transaction(params), to: TransactionService, as: :call
end
