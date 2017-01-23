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

defmodule Auberge.API.V1.RoomTypes do
  @moduledoc """
    Property Resource: base_url/api_version/roomtypes
  """
  use Maru.Router
  alias Auberge.Repo
  alias Auberge.Schema
  alias Auberge.RoomType
  alias Auberge.RoomRate
  ## Routes
  # GET /roomtypes
  # POST /roomtypes
  # GET /roomtypes/:type
  # PATCH /roomtypes/:type
  # DELETE /roomtypes/:type
  ## Future Routes
  # POST /roomtypes/:type/associate --- rate=:rate_id

  resource :roomtypes do

    get do
      roomtypes = Repo.all(RoomType) |> Repo.preload(:rates)
      if roomtypes do
        json(conn, roomtypes)
      else
        json(conn, [])
      end
    end

    params do
      requires :type, type: String
      requires :class, type: String
      optional :view, type: String
      optional :max_adults, type: String
      optional :max_children, type: String
      requires :bedding, type: Map do
        requires :type, type: String
        requires :quantity, type: Integer
      end
      optional :extra_bedding, type: Map do
        requires :type, type: String
        requires :quantity, type: Integer
        requires :frequency, type: String
        requires :surcharge, type: Integer
      end
      optional :smoking, type: Boolean
      optional :status, type: String
    end
    post do
      changeset = RoomType.changeset(%RoomType{}, params)
      |> Ecto.Changeset.put_assoc(:rooms, [])

      case Repo.insert(changeset) do
        {:ok, roomtype} ->
          roomtype = roomtype |> Repo.preload(:rates)
          conn |> put_status(201) |> json(roomtype)

        {:error, changeset} ->
          errors = Schema.errors(changeset)

          conn
          |> put_status(409)
          |> json(%{:domain => "roomtype",
                    :action => "create",
                    :errors => errors})
      end
    end

    params do
      requires :type_uuid, type: String,
        regexp: ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
    end
    route_param :type_uuid do
      get do
        type =
          RoomType
          |> RoomType.get_by_uuid(params[:type_uuid])
          |> Repo.one
          |> Repo.preload(:rates)

        if type do
          json(conn, type)
        else
          put_status(conn, 404)
        end
      end

      params do
        optional :type, type: String
        optional :class, type: String
        optional :view, type: String
        optional :max_adults, type: String
        optional :max_children, type: String
        optional :bedding, type: Map do
          optional :type, type: String
          optional :quantity, type: Integer
        end
        optional :extra_bedding, type: Map do
          optional :type, type: String
          optional :quantity, type: Integer
          optional :frequency, type: String
          optional :surcharge, type: Integer
        end
        optional :smoking, type: Boolean
        optional :status, type: String
      end
      patch do
        type =
          RoomType
          |> RoomType.get_by_uuid(params[:type_uuid])
          |> Repo.one

        if type do
          changeset = RoomType.changeset(type, params)

          case Repo.update(changeset) do
            {:ok, type} ->
              type = type |> Repo.preload(:rates)
              conn |> put_status(200) |> json(type)

            {:error, changeset} ->
              errors = Auberge.Schema.errors(changeset)

              conn
              |> put_status(409)
              |> json(%{:domain => "roomtype",
                        :action => "update",
                        :errors => errors})
          end
        else
          put_status(conn, 404)
        end
      end

      delete do
        type =
          RoomType
          |> RoomType.get_by_uuid(params[:type_uuid])
          |> Repo.one

        if type do
          case Repo.delete(type) do
            {:ok, type} ->
              type = type |> Repo.preload(type)
              conn |> put_status(200) |> json(type)

            {:error, error} ->
              conn
              |> put_status(409)
              |> json(%{:domain => "roomtype",
                        :action => "delete",
                        :errors => error})
          end
        else
          put_status(conn, 404)
        end
      end

      params do
        requires :roomrate_uuid, type: String,
          regexp: ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
      end
      post "/associate" do
        type =
          RoomType
          |> RoomType.get_by_uuid(params[:type_uuid])
          |> Repo.one

        rate =
          RoomRate
          |> RoomRate.get_by_uuid(params[:roomrate_uuid])
          |> Repo.one

        if type and rate do
          type =
            type
            |> Repo.preload(:rates)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:rates, [rate])
            case Repo.update(type) do
              {:ok, type} ->
                conn |> put_status(200) |> json(type)
              {:error, changeset} ->
                errors = Auberge.Schema.errors(changeset)

                conn
                |> put_status(409)
                |> json(%{:domain => "roomtype",
                          :action => "associate",
                          :errors => errors})
            end
        else
          conn
          |> put_status(409)
          |> json(%{:domain => "roomtype",
                    :action => "associate",
                    :errors => "Room Type or Room Rate is invalid/missing"})
        end
      end
    end
  end
end
