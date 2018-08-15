use Mix.Config

config :jack_marchant, JackMarchantWeb.Endpoint,
  server: true,
  load_from_system_env: true,
  http: [port: System.get_env("PORT")],
  url: [host: System.get_env("HOSTNAME"), port: System.get_env("PORT")],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :jack_marchant, JackMarchant.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 10

# Do not print debug messages in production
config :logger, level: :info
