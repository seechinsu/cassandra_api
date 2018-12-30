defmodule CassandraApiWeb.Router do
  use CassandraApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CassandraApiWeb do
    pipe_through :api
  end
end
