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

      {:error, code} ->
        conn
        |> put_status(code)
        |> put_view(CassandraApiWeb.ErrorView)
        |> render(:"#{code}")
    end
  end

  def get_by_email(conn, %{"email" => email}) do
    result =
      Accounts.get_user_by_email(email)
      |> case do
        {:ok, nil} -> {:error, 404}
        {:ok, user} -> {:ok, user.id}
      end
      |> case do
        {:ok, id} -> Accounts.get_user_by_id(id)
        {:error, code} -> {:error, code}
      end

    case result do
      {:ok, user} ->
        render(conn, "user.json", user: user)

      {:error, code} ->
        conn
        |> put_status(code)
        |> put_view(CassandraApiWeb.ErrorView)
        |> render(:"#{code}")
    end
  end

  def show(conn, %{"id" => id}) do
    case Accounts.get_user_by_id(id) do
      {:ok, nil} ->
        conn
        |> put_status(404)
        |> put_view(CassandraApiWeb.ErrorView)
        |> render(:"404")

      {:ok, user} ->
        render(conn, "user.json", user: user)

      {:error, _message} ->
        conn
        |> put_status(500)
        |> put_view(CassandraApiWeb.ErrorView)
        |> render(:"500")
    end
  end

  def index(conn, _params) do
    {:ok, users} = Accounts.list_users()
    render(conn, "index.json", users: users)
  end
end
