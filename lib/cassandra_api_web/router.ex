defmodule CassandraApiWeb.Router do
  use CassandraApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CassandraApiWeb do
    pipe_through :api

    get "/users", UserController, :get_by_email
    resources "/users", UserController
  end
end
