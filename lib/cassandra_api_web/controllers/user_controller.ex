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

  def index(conn, _params) do
    {:ok, users} = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

end
