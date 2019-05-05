defmodule Schema.User do
  require Schema.Seraph
  use Triton.Table

  table :users, keyspace: Schema.Seraph do
    # validators using vex
    field(:id, :uuid)
    field(:email, :text)
    field(:password_hash, :text)
    field(:avatar, :text)
    field(:inserted_at, :timestamp)
    field(:updated_at, :timestamp)
    partition_key([:email])
    cluster_columns([:id])
  end
end
