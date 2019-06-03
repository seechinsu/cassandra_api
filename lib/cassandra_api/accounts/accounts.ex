defmodule CassandraApi.Accounts do
  alias Schema.User
  alias Schema.UserCredentials
  # alias CassandraApi.Acccounts
  import Triton.Query

  defp insert_into_user(user, id) do
    User
    |> prepared(
      id: id,
      email: user["email"],
      avatar: user["avatar"],
      first_name: user["first_name"],
      last_name: user["last_name"]
    )
    |> insert(
      id: :id,
      email: :email,
      avatar: :avatar,
      first_name: :first_name,
      last_name: :last_name,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    )
    |> User.save()
  end

  defp insert_into_user_cred(user, id) do
    UserCredentials
    |> prepared(
      id: id,
      email: user["email"],
      password_hash: user["password_hash"]
    )
    |> insert(
      email: :email,
      id: :id,
      password_hash: :password_hash,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    )
    |> UserCredentials.save()
  end

  defp is_dup_email?(email) do
    case get_user_by_email(email) do
      {:ok, nil} -> false
      {:ok, _} -> true
    end
  end

  def create_user(user) do
    case is_dup_email?(user["email"]) do
      false ->
        new_user_uuid = UUID.uuid1(:default)

        [
          Task.async(fn -> insert_into_user(user, new_user_uuid) end),
          Task.async(fn -> insert_into_user_cred(user, new_user_uuid) end)
        ]
        |> Task.yield_many()
        |> Enum.all?(fn {_task, {res, _all}} -> res == :ok end)
        |> case do
          true -> {:ok, :success}
          _ -> {:error, 500}
        end

      true ->
        {:error, 409}
    end
  end

  def get_user_by_email(email) do
    UserCredentials
    |> prepared(email: email)
    |> select([:email, :id, :avatar, :inserted_at, :updated_at])
    |> where(email: :email)
    |> UserCredentials.one()
  end

  def get_user_by_id(id) do
    User
    |> prepared(id: id)
    |> select([:email, :id, :avatar, :inserted_at, :updated_at])
    |> where(id: :id)
    |> User.one()
  end

  def list_users do
    User
    |> select(:all)
    |> User.all()
  end
end
