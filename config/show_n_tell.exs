use Mix.Config

config :show_n_tell,
  github_org: System.get_env("GITHUB_ORG") || "decisely"
