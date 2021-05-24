defmodule Apipay.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table :transactions do
      add :value, :decimal
      add :from_id, references(:accounts, type: :binary_id)
      add :to_id, references(:accounts, type: :binary_id)

      timestamps()
    end
  end
end
