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

defmodule Auberge.API.V1.Rooms do
  use Maru.Router

  ## Future Routes
  # POST /rooms -- body has property_id
  # GET /rooms/:room
  # PATCH /rooms/:room
  # DELETE /rooms/:room
  # GET /rooms/:room/rates

  resource :rooms do
    post do
      conn
      |> put_status(200)
      |> json(%{:hello => "nah"})
    end

    route_param :type_uuid do
      get do

      end

      patch do

      end

      delete do

      end

      post "/rates" do
        conn
        |> put_status(200)
        |> json(%{:hello => "world"})
      end
    end
  end
end
