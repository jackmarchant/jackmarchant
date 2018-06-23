use Mix.Config

config :jack_marchant, JackMarchantWeb.Endpoint,
  load_from_system_env: true,
  http: [port: System.get_env("PORT")],
  url: [host: "jackmarchant.com", port: System.get_env("PORT")],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :jackmarchant, JackMarchant.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 10

# Do not print debug messages in production
config :logger, level: :info
