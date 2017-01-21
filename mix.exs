defmodule Auberge.Mixfile do
  use Mix.Project

  defp description do
    """
    The API server for Auberge Hotel Management.
    """
  end

  def project do
    [name: "Auberge API",
     app: :auberge,
     description: description(),
     package: package(),
     version: "17.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :maru, :postgrex, :ecto, :corsica],
     mod: {Auberge.Application, []}]
  end

  defp deps do
    [
      {:postgrex, ">= 0.0.0"},                    # PostgreSQL Driver
      {:ecto, "~> 2.1"},                          # Database DSL
      {:maru, "~> 0.11"},                         # API Framework
      {:maru_swagger, "~> 0.8"},                  # Swagger Spec Docs
      {:corsica, "~> 0.5"},                       # CORS
      {:credo, "~> 0.5", only: [:dev, :test]},    # Code Analysis/Review
      {:distillery, "~> 1.0"},                    # Release Management
      {:espec, "~> 1.2", only: [:dev, :test]},    # BDD Testing Framework
      {:exsync, "~> 0.1", only: :dev}             # Module Reloader
      # {:rollbax, "~> 0.6", only: :prod}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.create", "ecto.migrate"]]
  end

  defp package do
    [maintainers: ["Christopher Combs"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/combsco/auberge"}]
  end
end
