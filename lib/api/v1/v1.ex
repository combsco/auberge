defmodule Auberge.API.V1 do
  use Maru.Router

  version "v1"

  mount Auberge.API.V1.Hello
end
