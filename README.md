# CassandraApi

A simple REST api with Elixir, Phoenix Framework, and Cassandra.

Docker compose file is used to bring up a Cassandra container with port 9042 exposed along with a DataStax Studio container as a GUI to interact with Cassandra.

Run the following command to start up cassandra:

`docker-compose -f cassandra-single-node.yml up`

[Triton](https://github.com/blitzstudios/triton) is an Elixir Cassandra ORM built on top of [Xandra](https://github.com/lexhide/xandra), an Elixir Cassandra Driver. We will be using Triton and Xandra to interact with our cassandra nodes.

Important note:

When setting up your keyspace, if you're working in dev with a single Cassandra node, the replication factor has to be set to 1 or the default Quorum consistency level will throw a fit since it'll want a 2/3 majority but there's only 1 node.

The phoenix api project was generated with options `--no-html`, `--no-ecto`, and `--no-webpack` as Triton has no dependency on Ecto.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4001) from your browser.
