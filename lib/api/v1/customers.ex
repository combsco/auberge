defmodule Auberge.API.V1.Customers do
  use Maru.Router

  resource :customers do
    get do
      json(conn, %{:hello => "World"})
    end
  end

end
