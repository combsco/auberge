defmodule Auberge.Mixfile do
  use Mix.Project

  def project do
    [app: :auberge,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :maru, :postgrex, :ecto, :corsica]]
  end

  defp deps do
    [
      {:postgrex, ">= 0.0.0"},                  # PostgreSQL Driver
      {:ecto, "~> 2.0.0"},                      # ORM
      {:maru, "~> 0.11"},                       # API Framework
      {:corsica, "~> 0.5"},                     # CORS
      {:credo, "~> 0.5", only: [:dev, :test]},  # Code Analysis
      {:distillery, "~> 1.0"},                  # Release Management
      {:changex, ">= 0.0.0"}                    # Automated Changelog
    ]
  end
end
