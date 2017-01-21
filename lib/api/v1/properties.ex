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

defmodule Auberge.API.V1.Properties do
  @moduledoc """
    Property Resource: base_url/api_version/properties
  """
  use Maru.Router
  alias Auberge.Repo
  alias Auberge.Schema
  alias Auberge.Property

  # TODO - Delete Property, Update Property, Get Property
  # TODO - Create rooms / associate rooms?
  # TODO - Search properties
  # TODO - User Management per Property?
  # /property/{property_uuid}
  # /property/{property_uuid}/rooms
  # /rooms/{room_uuid}
  # /rooms/{room_uuid}/rates
  # /rates/{rates_uuid}

  resource :properties do
    desc "Create a new property."
    params do
      requires :name, type: String
      optional :address, type: Map do
        optional :premise, type: String
        requires :throughfare, type: String
        requires :locality, type: String
        requires :administrative_area, type: String
        requires :postal_code, type: String
        requires :country, type: String
      end
    end
    post do
      changeset = Property.changeset(%Property{}, params)
      |> Ecto.Changeset.put_assoc(:rooms, [])

      case Repo.insert(changeset) do
        {:ok, property} ->
          conn |> put_status(201) |> json(property)

        {:error, changeset} ->
          errors = Schema.errors(changeset)

          conn
          |> put_status(409)
          |> json(%{:domain => "property",
                    :action => "create",
                    :errors => errors})
      end
    end

    desc "Retrieve a specific property."
    params do
      requires :property_uuid, type: String,
        regexp: ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
    end
    get ":property_uuid" do
      property =
        Property
        |> Property.get_by_uuid(params[:property_uuid])
        |> Repo.one

      if property do
        json(conn, property)
      else
        put_status(conn, 404)
      end
    end
  end
end
