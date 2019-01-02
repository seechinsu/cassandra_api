defmodule Schema.Seraph do
  use Triton.Keyspace

  keyspace :seraph, conn: Triton.Conn do
    with_options [
      replication: "{'class' : 'SimpleStrategy', 'replication_factor': 1}"
    ]
  end
end
