use Mix.Config

# Do not include metadata/timestamps in logs
config :logger, :console, format: "[$level] $message\n"

# Setup repos and database adapaters
config :auberge, ecto_repos: [Auberge.Repo]
config :auberge, Auberge.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "auberge",
  username: "postgres",
  password: "",
  hostname: "lvh.me"

# Tell maru what port to listen on and how we version the API
config :maru, Auberge.API,
  versioning: [
    using: :path
  ],
  http: [port: 3000]
