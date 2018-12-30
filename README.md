# CassandraApi

A simple REST api with Elixir, Phoenix Framework, and Cassandra.

Docker compose file is used to bring up a cassandra container with port 9042 exposed.

Run the following command to start up cassandra:

`docker-compose -f docker-compose.yml up`

[Triton](https://github.com/blitzstudios/triton) is an Elixir Cassandra ORM built on top of [Xandra](https://github.com/lexhide/xandra), an Elixir Cassandra Driver. We will be using Triton and Xandra to interact with our cassandra nodes.

The phoenix api project was generated with options `--no-html`, `--no-ecto`, and `--no-webpack` as Triton has no dependency on Ecto.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4001) from your browser.
