# Copyright 2017 Christopher Combs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Auberge.API do
  @moduledoc false
  use Maru.Router
  require Logger

  before do
    plug Plug.Logger, log: :debug
    plug Corsica, max_age: 600, origins: "*",
         allow_headers: ["accept", "content-type", "origin", "authorization"]
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

  rescue_from Maru.Exceptions.InvalidFormat, as: e do
    conn
    |> put_status(422)
    |> json(%{:error => "Invalid Request",
              :error_description => "Invalid or missing #{e.param} parameter"})
  end

  # rescue_from Maru.Exceptions.Validation, as: e do
  #   conn
  #   |> put_status(422)
  #   |> json(%{:error => "Invalid Request",
  #             :error_description => "Invalid or missing #{e.param} parameter"})
  # end

  rescue_from :all, as: e do
    Logger.warn("API Error Occurred")
    Logger.debug(inspect(e))
    conn
    |> put_status(500)
    |> text("Internal Server Error")
  end

  mount Auberge.API.V1
end
