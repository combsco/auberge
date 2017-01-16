defmodule Auberge.Customer do
  @moduledoc false
  use Ecto.Schema

  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_num
    field :email

    timestamps()
  end
end

defimpl Poison.Encoder, for: Auberge.Customer do
  @attributes ~w(id first_name last_name phone_num email)a

  def encode(customer, options) do
    customer
    |> Map.take(@attributes)
    |> Poison.Encoder.encode(options)
  end
end
