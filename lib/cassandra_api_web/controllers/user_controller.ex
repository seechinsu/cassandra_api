defmodule CassandraApiWeb.UserController do
  use CassandraApiWeb, :controller
  alias CassandraApi.Accounts

  action_fallback CassandraApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> render("created.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    {:ok, user} = Accounts.get_user_by_id(id)
    render(conn, "user.json", user: user)
  end


end
