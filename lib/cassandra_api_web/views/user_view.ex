defmodule CassandraApiWeb.UserView do

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email, avatar: user.avatar}
  end

  def render("created.json", %{message: message}) do
    %{response: message}
  end

end
