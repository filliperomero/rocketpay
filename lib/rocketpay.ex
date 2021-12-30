defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate

  alias Rocketpay.Accounts.Deposit

  # This will create a "fachada", which will give us the ability to call
  # the following method anywhere in the code by just using Rocketpay.create_user(%{})
  # as: :call => Will invoke the 'call' funcion inside Rocketpay.Users.Create
  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
end
