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

### Authorization Process Overview

This API allows client applications to authorize via GitHub, using the [web application flow](https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#web-application-flow). If you plan on building a client to interact with this API, this is a quick reference for how to set up user authorization.

Some of this API is publicly available, however some parts are only accessable to authorized users. Authorized users are identified by an Authorization request header:

```
Authorization: bearer <generated-token-here>
```

To obtain a token, client applications should implement the following process:

1. Redirect unauthorized users to `https://github.com/login/oauth/authorize?client_id=client-id-here?redirect_uri=redirect-uri-here` in order to request their identity.

The user will be prompted to enter their GitHub login information. If successfull, the user is redirected back to the client application (determined from the `redirect_uri` parameter provided) with a temporary `code` parameter.

2. POST the temporary code to `/api/authenticate`.

```
POST http://localhost:4000/api/authenticate

Parameters

github_code -- string -- The temporary code from the previous step
state -- string -- A random string
```

The show-n-tell API then receives this request, adds a few more parameters, and does a POST to GitHub in order to obtain an access token. If this is the first time a user has authorized with the show-n-tell API, a new user will be added to the database, otherwise, the user is retreived from the database. Finally, the access token is returned to the client application.

3. Subsequent requests to the show-n-tell server requiring authorization should include the access token in the header.
