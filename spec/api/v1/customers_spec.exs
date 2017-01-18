defmodule CustomersSpec do
  use ESpec
  use Maru.Test, for: Auberge.API.V1.Customers
  alias Ecto.Adapters.SQL
  alias Auberge.Repo
  alias Auberge.Customer

  before_all do
    SQL.query!(Repo, "TRUNCATE customers RESTART IDENTITY;", [])
  end

  describe "Customers API" do
    before do
      customer = %Customer{first_name: "Christopher",
                           last_name: "Combs",
                           email: "hey@chriscombs.me",
                           phone_num: "5555555555"}
                |> Repo.insert!
                |> Poison.encode!

      {:shared, customer: customer}
    end
    finally do: SQL.query!(Repo, "TRUNCATE customers RESTART IDENTITY;", [])

    it "can retrieve a specific customer by id" do
      response = get("/customers/1")
      expect response.status |> to(eq 200)
      expect response.resp_body |> to(eq shared.customer)
    end
    it "can update a specific customer by id" do
      response = build_conn()
                  |> Plug.Conn.put_req_header("content-type", "application/json")
                  |> put_body_or_params(Poison.encode!(%{first_name: "Jane"}))
                  |> patch("/customers/1")

      customer = %{id: 1,
                   first_name: "Jane",
                   last_name: "Combs",
                   email: "hey@chriscombs.me",
                   phone_num: "5555555555"}
                 |> Poison.encode!

      expect response.status |> to(eq 200)
      expect response.resp_body |> to(eq customer)
    end
    it "can delete a specific customer by id" do
      response = delete("/customers/1")

      expect response.status |> to(eq 204)
      expect response.resp_body |> to(eq "No Content")
    end
    it "can create a new customer" do
      customer = %Customer{first_name: "John",
                           last_name: "Doe",
                           email: "john.doe@gmail.com",
                           phone_num: "5555555555"}

      response = build_conn()
                  |> Plug.Conn.put_req_header("content-type", "application/json")
                  |> put_body_or_params(customer |> Poison.encode!)
                  |> post("/customers")

      expected_customer = customer |> Map.put(:id, 2) |> Poison.encode!

      expect response.status |> to(eq 201)
      expect response.resp_body |> to(eq expected_customer)
    end
  end
end
