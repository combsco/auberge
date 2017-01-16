defmodule Auberge.Customer do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_num
    field :email

    timestamps()
  end

  @required_params ~w(first_name last_name)
  @optional_params ~w(phone_num email)

  def changeset(customer, params \\ :empty) do
    customer
    |> cast(params, @required_params, @optional_params)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:first_name, max: 30)
    |> validate_length(:last_name, max: 30)
    |> validate_length(:phone_num, max: 15)
    |> validate_length(:email, max: 254)
    |> unique_constraint(:email, on: Auberge.Repo)
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
