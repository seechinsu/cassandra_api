defmodule CassandraApiWeb.UserView do

  def render("user.json", %{user: user}) do
    user_json(user)
  end

  def render("created.json", %{message: message}) do
    %{response: message}
  end

  def render("index.json", %{users: users}) do
    %{
      users: Enum.map(users, &user_json/1)
    }
  end

  def user_json(user) do
    %{
      id: user.id,
      email: user.email,
      avatar: user.avatar
    }
  end

end
