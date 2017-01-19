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

  resource :customers do

    desc "Retrieve a customer's profile."
    params do
      requires :customer_id, type: Integer
    end
    get ":customer_id" do
      customer_id = params[:customer_id]
      customer = Repo.one(from c in Customer,
                          where: is_nil(c.deleted_at) and c.id == ^customer_id)

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
          conn
          |> put_status(201)
          |> json(customer)
        {:error, changeset} ->
          errors = Changeset.traverse_errors(changeset, fn msg -> msg end)
          conn
          |> put_status(400)
          |> json(%{:error => "Error Creating",
                    :error_description => errors})
      end
    end

    desc "Update an existing customer."
    params do
      requires :customer_id, type: Integer
      optional :first_name, type: String
      optional :last_name, type: String
      optional :phone_num, type: String
      optional :email, type: String
      at_least_one_of [:first_name, :last_name, :phone_num, :email]
    end
    patch ":customer_id" do
      customer_id = params[:customer_id]
      customer = Repo.one(from c in Customer,
                          where: is_nil(c.deleted_at) and c.id == ^customer_id)

      if customer do
        changeset = Customer.changeset(customer, params)

        case Repo.update(changeset) do
          {:ok, customer} ->
            conn
            |> put_status(200)
            |> json(customer)
          {:error, changeset} ->
            errors = Changeset.traverse_errors(changeset, fn msg -> msg end)
            conn
            |> put_status(400)
            |> json(%{:error => "Error Updating",
                      :error_description => errors})
        end
      else
        put_status(conn, 404)
      end
    end

    desc "Deletes an existing customer."
    params do
      requires :customer_id, type: Integer
    end
    delete ":customer_id" do
      customer_id = params[:customer_id]
      customer = Repo.one(from c in Customer,
                          where: is_nil(c.deleted_at) and c.id == ^customer_id)

      if customer do
        changeset = Customer.changeset(customer, %{deleted_at: DateTime.utc_now()})
        case Repo.update(changeset) do
          {:ok, customer} ->
            conn
            |> put_status(204)
            |> text("No Content")
          {:error, changeset} ->
            errors = Changeset.traverse_errors(changeset, fn msg -> msg end)
            conn
            |> put_status(400)
            |> json(%{:error => "Error Deleting",
                      :error_description => errors})
        end
      else
        put_status(conn, 404)
      end
    end
    # search, build up query based on if params were given
  end
end
