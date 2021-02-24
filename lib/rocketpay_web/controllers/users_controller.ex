defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  # We say to Pheonix that we have a fallback Controller
  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    # 'with' is also a pattern match, where he verifies the case and if this case works
    # he will execute the body of the function.
    # If an error occurs, pheonix will receive this error and since we have an 'action_fallback' in place,
    # the error will be handle by our fallback
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
