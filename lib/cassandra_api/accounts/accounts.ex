defmodule CassandraApi.Accounts do
  alias Schema.User
  import Triton.Query

  def create_user(%{
        "avatar" => avatar,
        "email" => email,
        "password_hash" => password
      }) do
    User
    |> prepared(
      id: UUID.uuid1(:default),
      email: email,
      password_hash: password,
      avatar: avatar
    )
    |> insert(
      id: :id,
      email: :email,
      password_hash: :password_hash,
      avatar: :avatar,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    )
    |> if_not_exists
    |> User.save()
  end

  def get_user_by_id(id) do
    User
    |> prepared(id: id)
    |> select([:id, :email, :avatar])
    |> where(id: :id)
    |> User.one()
  end

  @spec get_user_by_email(any()) :: {:error, binary()} | {:ok, any()}
  def get_user_by_email(email) do
    User
    |> prepared(email: email)
    |> select([:id, :email])
    |> where(email: :email)
    |> User.one()
  end

  def list_users do
    User
    |> select(:all)
    |> User.all()
  end
end
