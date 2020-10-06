# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ims,
  ecto_repos: [Ims.Repo]

# Configures the endpoint
config :ims, ImsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KIX7dCpNyNt+1CcyezfI+AvMzY+5L1+0b2wfGCQApduxet1aCGHSBGgKHYHjBrhR",
  render_errors: [view: ImsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ims.PubSub,
  live_view: [signing_salt: "OyIf+2tu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :logger,
  backends: [:console, Sentry.LoggerBackend]

config :sentry,
  dsn: "http://65ea2e9040764d75ab86820db8e01aea@127.0.0.1:9000/2"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
