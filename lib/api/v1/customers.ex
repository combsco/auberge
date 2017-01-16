defmodule Auberge.API.V1.Customers do
  @moduledoc """
    Customers Resource: base_url/api_version/customers

    Allows you to retrieve a customer, update, and delete customers.
  """
  use Maru.Router
  import Ecto.Query, only: [from: 2]
  alias Auberge.Repo
  alias Auberge.Customer

  resource :customers do

    desc "Retrieve a customer's profile."
    params do
      requires :customer_id, type: Integer
    end
    get ":customer_id" do
      customer_id = params[:customer_id]
      customer = Repo.one(from c in Customer, where: c.id == ^customer_id)
      if customer do
        json(conn, customer)
      else
        put_status(conn, 404)
      end
    end

    desc "Create a new customer"
    params do
      requires :first_name, type: String
      requires :last_name, type: String
      optional :phone_num, type: String
      optional :email, type: String
    end
    post do
      changeset = Customer.changeset(%Customer{}, params)

      case Repo.insert(changeset) do
        {:ok, customer} ->
          conn
          |> put_status(201)
          |> json(customer)
        {:error, changeset} ->
          errors = Ecto.Changeset.traverse_errors(changeset, fn msg -> msg end)
          conn
          |> put_status(400)
          |> json(%{:error => "Error Creating",
                    :error_description => errors})
      end
    end
  end
end
