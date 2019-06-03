defmodule Schema.UserCredentials do
  require Schema.Seraph
  use Triton.Table

  table :user_credentials, keyspace: Schema.Seraph do
    # validators using vex
    field(:email, :text)
    field(:id, :uuid)
    field(:password_hash, :text)
    field(:inserted_at, :timestamp)
    field(:updated_at, :timestamp)
    partition_key([:email])
    cluster_columns([:inserted_at])
  end
end
