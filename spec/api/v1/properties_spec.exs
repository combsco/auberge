defmodule PropertiesSpec do
  use ESpec
  use Maru.Test, for: Auberge.API.V1.Properties
  alias Ecto.Adapters.SQL
  alias Auberge.Repo
  alias Auberge.Customer

  # before_all do
  #   SQL.query!(Repo, "TRUNCATE properties RESTART IDENTITY;", [])
  #   SQL.query!(Repo, "TRUNCATE rooms RESTART IDENTITY;", [])
  # end
end
