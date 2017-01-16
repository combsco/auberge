defmodule Customer do
  use Ecto.Schema

  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_num
    field :email
    timestamps
  end
end
