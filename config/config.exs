# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :searchlight,
  ecto_repos: [Searchlight.Repo]

# Configures the endpoint
config :searchlight, Searchlight.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OnD8FloyqjBkFys4a2hTIn2eCU7Pb+63AFDTVcZXGbjPFHxpHDsZNOJRpLs7rqQ+",
  render_errors: [view: Searchlight.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Searchlight.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure guardian

config :guardian, Guardian,
  issuer: "Searchlight",
  ttl: {3, :days},
  verify_issuer: true,
  secret_key: "K5U15rCwqam0hz3EYovOp133hij04IVoFtsbKTgfxwdfBL91zBb8mH2WqzgMtpXC",
  serializer: Searchlight.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
