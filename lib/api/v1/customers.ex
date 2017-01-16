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
  end
end
