# ShowNTell

[![Build Status](https://travis-ci.org/denvaar/show-n-tell.svg?branch=master)](https://travis-ci.org/denvaar/show-n-tell)

[How to fork and contribute to this repo](/Contributing%20to%20Open%20Source%20on%20GitHub.pdf)

### Development Setup

1. Add the configuration secrets in `config/show_n_tell.secret.exs`

```elixir
use Mix.Config

config :show_n_tell,
  github_client_id: "<client-id-here>"
  github_client_secret: "<secret-id-here>"
```

2. Run the development server: `mix phx.server`

3. Use the handy GraphQL Workspace tool to play around: `http://localhost:4000/graphiql`
