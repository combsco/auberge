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

defmodule Auberge.API.V1.Customers do
  @moduledoc """
    Customers Resource: base_url/api_version/customers

    Allows you to retrieve a customer, update, and delete customers.
  """
  use Maru.Router
  alias Auberge.Repo
  alias Auberge.Customer
  alias Auberge.Schema

  # TODO - Searching for a customer by first/last/address/etc
  # TODO - Customer Create / Get / Update add address embedded schema

  resource :customers do

    desc "Create a new customer."
    params do
      requires :first_name, type: String
      requires :last_name, type: String
      optional :phone_num, type: String
      optional :email, type: String
      at_least_one_of [:phone_num, :email]
    end
    post do
      changeset = Customer.changeset(%Customer{}, params)

      case Repo.insert(changeset) do
        {:ok, customer} ->
          conn |> put_status(201) |> json(customer)

        {:error, changeset} ->
          errors = Schema.errors(changeset)

          conn
          |> put_status(409)
          |> json(%{:domain => "customer",
                    :action => "create",
                    :errors => errors})
      end
    end

    params do
      requires :customer_uuid, type: String,
        regexp: ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/
    end
    route_param :customer_uuid do
      desc "Retrieve a specific customer."
      get do
        customer =
          Customer
          |> Customer.get_by_uuid(params[:customer_uuid])
          |> Repo.one

        if customer do
          json(conn, customer)
        else
          put_status(conn, 404)
        end
      end

      desc "Update an existing customer."
      params do
        optional :first_name, type: String
        optional :last_name, type: String
        optional :phone_num, type: String
        optional :email, type: String
        at_least_one_of [:first_name, :last_name, :phone_num, :email]
      end
      patch do
        customer =
          Customer
          |> Customer.get_by_uuid(params[:customer_uuid])
          |> Repo.one

        if customer do
          changeset = Customer.changeset(customer, params)

          case Repo.update(changeset) do
            {:ok, customer} ->
              conn |> put_status(200) |> json(customer)

            {:error, changeset} ->
              errors = Auberge.Schema.errors(changeset)

              conn
              |> put_status(409)
              |> json(%{:domain => "customer",
                        :action => "update",
                        :errors => errors})
          end
        else
          put_status(conn, 404)
        end
      end

      desc "Deletes an existing customer."
      delete do
        customer =
          Customer
          |> Customer.get_by_uuid(params[:customer_uuid])
          |> Repo.one

        if customer do
          case Repo.delete(customer) do
            {:ok, customer} ->
              conn |> put_status(200) |> json(customer)
            {:error, error} ->
              conn
              |> put_status(409)
              |> json(%{:domain => "customer",
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
