defmodule Auberge.Address do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :premise, :string             # Apt 201
    field :throughfare, :string         # 284 Race Avenue
    field :locality, :string            # East Strousburg
    field :administrative_area, :string # PA
    field :postal_code, :string         # 18301
    field :country, :string             # USA
  end

  @required_params ~w(throughfare locality administrative_area postal_code country)a

  def changeset(address, params \\ :empty) do
    address
    |> cast(params, [:throughfare, :locality, :administrative_area, :postal_code, :country])
    |> validate_required(@required_params)
  end
end
