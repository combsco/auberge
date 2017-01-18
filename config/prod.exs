use Mix.Config

## SET ENVIROMENT VARS ##
# DATABASE_URL
# PORT

# Do not include metadata/timestamps in logs
config :logger, level: :info

# Setup repos and database adapaters
config :auberge, ecto_repos: [Auberge.Repo]
config :auberge, Auberge.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"}

# Tell maru what port to listen on and how we version the API
config :maru, Auberge.API,
  versioning: [
    using: :path
  ],
  http: [port: {:system, "PORT"}]
