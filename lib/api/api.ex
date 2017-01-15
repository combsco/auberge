defmodule Auberge.API do
  use Maru.Router

  before do
    plug Plug.Logger, log: :debug
    plug Corsica, max_age: 600, origins: "*", allow_headers: ["accept", "content-type", "origin", "authorization"]
  end

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  rescue_from Maru.Exceptions.NotFound do
    conn
    |> put_status(404)
    |> text("Resource Not Found")
  end

  rescue_from Maru.Exceptions.MethodNotAllowed do
    conn
    |> put_status(501)
    |> text("Not Implemented")
  end

  rescue_from Maru.Exceptions.InvalidFormatter, as: e do
    conn
    |> put_status(400)
    |> json(%{:error => "Invalid Request",
              :error_description => "Invalid or missing #{e.param} parameter"})
  end

  rescue_from :all, as: e do
    IO.inspect(e) # Remove in Prod?
    conn
    |> put_status(500)
    |> text("Internal Server Error")
  end

  mount Auberge.API.V1
end
