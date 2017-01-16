defmodule Auberge.API.V1 do
  @moduledoc false
  use Maru.Router

  version "v1"

  mount Auberge.API.V1.Hello
  mount Auberge.API.V1.Customers
end
