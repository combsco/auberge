defmodule Auberge.Property do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset
  alias Auberge.Address

  schema "properties" do
    field :name, :string         # Ovalii Hotel & Suites
    embeds_one :address, Auberge.Address

    timestamps()
    field :deleted_at, :naive_datetime

    has_many :rooms, Auberge.Room

    def changeset(property, params \\ :empty) do
      property
      |> cast(params, [:name])
      |> cast_embed(:address, with: &Address.changeset/2)
    end
  end

end
