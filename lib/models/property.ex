defmodule Auberge.Property do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset
  alias Auberge.Address
  alias Auberge.Room

  @derive {Poison.Encoder, only: [:id, :name, :address, :rooms, :inserted_at, :updated_at]}

  schema "properties" do
    field :name, :string         # Ovalii Hotel & Suites
    embeds_one :address, Address

    timestamps()
    field :deleted_at, :naive_datetime

    has_many :rooms, Room
  end

  def changeset(property, params \\ :empty) do
    property
    |> cast(params, [:name])
    |> cast_embed(:address, required: false)
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 30)
  end
end

# defimpl Poison.Encoder, for: Auberge.Property do
#   @attributes ~w(name address inserted_at updated_at)a
#
#   def encode(property, options) do
#     IO.inspect property
#
#     property
#     |> Map.take(@attributes)
#     |> Poison.Encoder.encode(options)
#   end
# end
