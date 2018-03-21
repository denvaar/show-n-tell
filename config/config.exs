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
  secret_key_base: "P71dpWbYyUl9D7MJOnuaE0YH0KGJqVxccsLh4Pwou1GgMwFLvv1r0iJsZ766sgq4",
  render_errors: [view: ShowNTellWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShowNTell.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
