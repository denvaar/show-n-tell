# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :show_n_tell,
  ecto_repos: [ShowNTell.Repo]

# Configures the endpoint
config :show_n_tell, ShowNTellWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eJpQBDM49IF7QNvuz4EA2xTBWgLkJrB72gLoTE/tDo4QPbcJoWSU2qVe3E0PwX63",
  render_errors: [view: ShowNTellWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ShowNTell.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Import application-specific config: optional params with good defaults.
import_config "show_n_tell.exs"
