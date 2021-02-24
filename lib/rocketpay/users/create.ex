defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{User, Repo, Account}

  def call(params) do
    # Starts a 'multi' operation
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    # Multi.run allows to read the result of the previous operation
    # The anonymous function, the second arg is the same name as the one used in the 'Multi.insert'
    # So, if the operation runs without problem, you'll receive the result on this arg
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user)
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
      preload_data(repo, user)
    end)
    |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}
    Account.changeset(params)
  end

  defp run_transaction(multi) do
    # case is also a pattern match
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      # receives ok and the last name of the operation
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
