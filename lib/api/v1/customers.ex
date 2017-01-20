defmodule Auberge.API.V1.Customers do
  @moduledoc """
    Customers Resource: base_url/api_version/customers

    Allows you to retrieve a customer, update, and delete customers.
  """
  use Maru.Router
  import Ecto.Query, only: [from: 2]
  alias Ecto.Changeset
  alias Auberge.Repo
  alias Auberge.Customer
  alias Auberge.Schema

  # TODO - Searching for a customer by first/last/address/etc
  # TODO - Customer Create / Get / Update add address embedded schema

  resource :customers do

    desc "Retrieve a specific customer."
    params do
      requires :customer_uuid, type: String
    end
    get ":customer_uuid" do
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

    desc "Update an existing customer."
    params do
      requires :customer_uuid, type: String
      optional :first_name, type: String
      optional :last_name, type: String
      optional :phone_num, type: String
      optional :email, type: String
      at_least_one_of [:first_name, :last_name, :phone_num, :email]
    end
    patch ":customer_uuid" do
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
    params do
      requires :customer_uuid, type: String
    end
    delete ":customer_uuid" do
      customer =
        Customer
        |> Customer.get_by_uuid(params[:customer_uuid])
        |> Repo.one

      if customer do
        changeset = Customer.changeset(customer, %{deleted_at: DateTime.utc_now()})

        case Repo.update(changeset) do
          {:ok, customer} ->
            conn |> put_status(200) |> json(customer)

          {:error, changeset} ->
            errors = Auberge.Schema.errors(changeset)

            conn
            |> put_status(409)
            |> json(%{:domain => "customer",
                      :action => "delete",
                      :errors => errors})
        end
      else
        put_status(conn, 404)
      end
    end
  end
end
