# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shelving,
  ecto_repos: [Shelving.Repo]

# Configures the endpoint
config :shelving, ShelvingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KFpyDV4Gg647W9P/GgPjvoPK7VwahE2VW9HSd3/kmdAsPbyHyeQzUP7z9GvG9lai",
  render_errors: [view: ShelvingWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Shelving.PubSub,
  live_view: [signing_salt: "/T03Dz9r"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :shelving, Shelving.Guardian,
  issuer: "shelving",
  secret_key: "fDWpGBdXpkNp1X9cG8peVPnZqBqCDEfQ+44WhLPb0YAvciJkXZUOoQkwYQ/ibpvP"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
