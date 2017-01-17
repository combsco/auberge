defmodule Auberge.Property do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :name, :string         # Ovalii Hotel & Suites
    embeds_one :address, Auberge.Address

    timestamps()
    field :deleted_at, Ecto.DateTime

    has_many :rooms, Auberge.Room

    def changeset(property, params \\ :empty) do
      property
      |> cast(params, [:name])
      |> cast_embed(:address, with: &Auberge.Address.changeset/2)
    end
  end

end
