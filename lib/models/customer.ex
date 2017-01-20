defmodule Auberge.Customer do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset
  import Ecto.Query

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :phone_num, :email, :inserted_at, :updated_at]}

  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_num, :string
    field :email, :string

    timestamps()
    field :deleted_at, :utc_datetime
  end

  def changeset(customer, params \\ :empty) do
    customer
    |> cast(params, [:first_name, :last_name, :phone_num, :email, :deleted_at])
    |> validate_required([:first_name, :last_name, :email])
    |> validate_length(:first_name, min: 2, max: 30)
    |> validate_length(:last_name, min: 2, max: 30)
    |> validate_length(:phone_num, max: 15)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:email, max: 254)
    |> unique_constraint(:email)
  end

  def get_by_uuid(query, uuid) do
    from c in query,
    where: is_nil(c.deleted_at) and c.id == ^uuid
  end
end
