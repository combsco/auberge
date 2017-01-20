defmodule Auberge.API.V1.Properties do
  @moduledoc """
    Property Resource: base_url/api_version/properties
  """
  use Maru.Router
  alias Auberge.Repo
  alias Auberge.Schema
  alias Auberge.Property

  # TODO - Create a Property, Delete Property, Update Property, Get Property
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
          # IO.inspect property
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
  end
end
