defmodule Auberge.API.V1.Properties do
  @moduledoc """
    Property Resource: base_url/api_version/properties
  """
  use Maru.Router
  import Ecto.Query, only: [from: 2]
  alias Auberge.Repo
  alias Auberge.Property
  alias Auberge.Room

  resource :properties do

  end
end
