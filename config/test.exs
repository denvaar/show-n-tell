use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :show_n_tell, ShowNTellWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :show_n_tell, ShowNTell.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "show_n_tell_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure tesla for tests
config :tesla, adapter: Tesla.Mock

# Configure Show & Tell values for test: defaults.
config :show_n_tell,
  github_client_id: "test-client-id",
  github_client_secret: "test-client-secret"
