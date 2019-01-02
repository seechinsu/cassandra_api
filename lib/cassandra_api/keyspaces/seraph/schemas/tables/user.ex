defmodule Schema.User do
  require Schema.Seraph
  use Triton.Table

  table :users, keyspace: Schema.Seraph do
    field :id, :bigint, validators: [presence: true]  # validators using vex
    field :email, :text
    field :password_hash, :text
    field :avatar, :text
    field :inserted_at, :timestamp
    field :updated_at, :timestamp
    partition_key [:id]
  end
end
