use Mix.Config

config :show_n_tell,
  github_org: System.get_env("GITHUB_ORG") || "decisely",
  github_client_id: (System.get_env("GITHUB_CLIENT_ID") || raise "must set environment variable GITHUB_CLIENT_ID"),
  github_client_secret: (System.get_env("GITHUB_CLIENT_SECRET") || raise "must set environment variable GITHUB_CLIENT_SECRET")
