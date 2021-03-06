# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jack_marchant, ecto_repos: [JackMarchant.Repo]

# Configures the endpoint
config :jack_marchant, JackMarchantWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1GbRaQvqbr0ofBbhxyuQxvRLeDDb5e/iZjaafcwlTSSLBtBk23bVLmJtR4bNnXuF",
  render_errors: [view: JackMarchantWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JackMarchant.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_campaign_monitor,
  api_key: System.get_env("CAMPAIGN_MONITOR_API_KEY"),
  list_id: System.get_env("CAMPAIGN_MONITOR_LIST_ID")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
