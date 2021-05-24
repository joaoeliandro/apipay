defmodule Apipay do
  alias Apipay.Users.Create, as: UserCreate

  alias Apipay.Accounts.Deposit
  # alias Apipay.Accounts.Withdraw

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  # defdelegate withdraw(params), to: Withdraw, as: :call
end
