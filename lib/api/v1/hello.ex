defmodule Auberge.API.V1.Hello do
  use Maru.Router

  namespace :hello do
    get do
      json(conn, %{:hello => "World"})
    end
  end
end
