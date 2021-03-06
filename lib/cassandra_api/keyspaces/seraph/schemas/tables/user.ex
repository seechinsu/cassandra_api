defmodule Schema.User do
  require Schema.Seraph
  use Triton.Table

  table :users, keyspace: Schema.Seraph do
    # validators using vex
    field(:id, :uuid)
    field(:email, :text)
    field(:first_name, :text)
    field(:last_name, :text)
    field(:avatar, :text)
    field(:inserted_at, :timestamp)
    field(:updated_at, :timestamp)
    partition_key([:id])
    cluster_columns([:inserted_at])
  end
end
