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

defmodule Auberge.API.V1.RoomRates do
  @moduledoc """
    Property Resource: base_url/api_version/roomrates
  """
  use Maru.Router
  alias Auberge.Repo
  alias Auberge.Schema
  alias Auberge.RoomRate

  ## Routes
  # GET /roomrates
  # GET /roomrates/:rate
  # DELETE /roomrates/:rate
  # POST /roomrates
  # PATCH /roomrates/:rate

  resource :roomrates do

    get do
      roomrates = Repo.all(RoomRate)
      if roomrates do
        json(conn, roomrates)
      else
        json(conn, [])
      end
    end

    params do
      requires :name, type: String
      requires :short_code, type: String
      requires :type, type: String
      requires :starts_at, type: String,
        regexp: ~r/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
      requires :ends_at, type: String,
        regexp: ~r/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
      requires :effective_days, type: Map do
        requires :monday, type: Boolean
        requires :tuesday, type: Boolean
        requires :wednesday, type: Boolean
        requires :thursday, type: Boolean
        requires :friday, type: Boolean
        requires :saturday, type: Boolean
        requires :sunday, type: Boolean
      end
      optional :min_stay, type: Integer
      optional :max_stay, type: Integer
      optional :min_occupancy, type: Integer
      optional :max_occupancy, type: Integer
      optional :extra_adult_price, type: Integer
      optional :extra_child_price, type: Integer
      optional :price, type: Integer
      optional :price_model, type: String
      optional :status, type: String
    end
    post do
      changeset = RoomRate.changeset(%RoomRate{}, params)

      case Repo.insert(changeset) do
        {:ok, rate} ->
          conn |> put_status(201) |> json(rate)

        {:error, changeset} ->
          errors = Schema.errors(changeset)

          conn
          |> put_status(409)
          |> json(%{:domain => "roomrate",
                    :action => "create",
                    :errors => errors})
      end
    end

    params do
      requires :rate_uuid, type: String,
        regexp: ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
    end
    route_param :rate_uuid do
      get do
        rate =
          RoomRate
          |> RoomRate.get_by_uuid(params[:rate_uuid])
          |> Repo.one

        if rate do
          json(conn, rate)
        else
          put_status(conn, 404)
        end
      end

      params do
        optional :name, type: String
        optional :short_code, type: String
        optional :type, type: String
        optional :starts_at, type: String,
          regexp: ~r/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
        optional :ends_at, type: String,
          regexp: ~r/^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
        optional :effective_days, type: Map do
          requires :monday, type: Boolean
          requires :tuesday, type: Boolean
          requires :wednesday, type: Boolean
          requires :thursday, type: Boolean
          requires :friday, type: Boolean
          requires :saturday, type: Boolean
          requires :sunday, type: Boolean
        end
        optional :min_stay, type: Integer
        optional :max_stay, type: Integer
        optional :min_occupancy, type: Integer
        optional :max_occupancy, type: Integer
        optional :extra_adult_price, type: Integer
        optional :extra_child_price, type: Integer
        optional :price, type: String
        optional :price_model, type: String
        optional :status, type: String
      end
      patch do
        rate =
          RoomRate
          |> RoomRate.get_by_uuid(params[:rate_uuid])
          |> Repo.one

        if rate do
          changeset = RoomRate.changeset(rate, params)

          case Repo.update(changeset) do
            {:ok, rate} ->
              conn |> put_status(201) |> json(rate)

            {:error, changeset} ->
              errors = Schema.errors(changeset)

              conn
              |> put_status(409)
              |> json(%{:domain => "roomrate",
                        :action => "update",
                        :errors => errors})
          end
        else
          put_status(conn, 404)
        end
      end

      delete do
        rate =
          RoomRate
          |> RoomRate.get_by_uuid(params[:rate_uuid])
          |> Repo.one

        if rate do
          case Repo.delete(rate) do
            {:ok, rate} ->
              conn |> put_status(200) |> json(rate)

            {:error, error} ->
              conn
              |> put_status(409)
              |> json(%{:domain => "roomrate",
                        :action => "delete",
                        :errors => error})
          end
        else
          put_status(conn, 404)
        end
      end
    end
  end
end
