defmodule Apipay.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Apipay.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:from_id, :to_id, :value]

  schema "transactions" do
    field :value, :decimal
    belongs_to :from, Account
    belongs_to :to, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
