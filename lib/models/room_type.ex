defmodule Auberge.RoomType do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset

  schema "room_types" do
    field :description, :string  # Guest
    field :num_of_beds, :integer # 2
    field :type_of_beds, :string # Double

    timestamps()
    field :deleted_at, :utc_datetime

    has_many :rooms, Auberge.Room
    many_to_many :rates, Auberge.RoomRate, join_through: "room_rates_types"
  end

  def changeset(room_type, params \\ :empty) do
    room_type
    |> cast(params, [:description, :num_of_beds, :type_of_beds])
  end
end
