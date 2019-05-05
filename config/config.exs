# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :cassandra_api, CassandraApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uA5awJE07B0cdZVVZ+NQ76Ud0gVYIh1Cy+xvFozrDPSvL3llC/MuuTrYq1yi0IcO",
  render_errors: [view: CassandraApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CassandraApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Triton
config :triton,
  clusters: [
    [
      conn: Triton.Conn,
      # nodes: ["127.0.0.1:9042", "127.0.0.1:9041", "127.0.0.1:9043"],
      nodes: ["127.0.0.1:9042"],
      pool: Xandra.Cluster,
      underlying_pool: DBConnection.Poolboy,
      pool_size: 10,
      keyspace: "seraph",
      authentication:
        {Xandra.Authenticator.Password, [username: "cassandra", password: "cassandra"]},
      # optional: (default is 5000)
      health_check_delay: 2500,
      # optional: (default is 1000)
      health_check_interval: 500
    ]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
