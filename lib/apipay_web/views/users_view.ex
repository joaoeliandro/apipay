defmodule ApipayWeb.UsersView do
  alias Apipay.{Account, User}

  def render("create.json", %{
        user: %User{
          account: %Account{id: account_id, balance: balance},
          id: id,
          email: email,
          name: name,
          age: age,
          nickname: nickname
        }
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        age: age,
        email: email,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
