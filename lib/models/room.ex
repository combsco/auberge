defmodule Auberge.Room do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :room_num, :string            # 701A
    field :floor_num, :integer          # 7

    timestamps()
    field :deleted_at, :utc_datetime

    belongs_to :property, Auberge.Property
    belongs_to :room_type, Auberge.RoomType
  end

  def changeset(room, params \\ :empty) do
      room
      |> cast(params, [:room_num, :floor_num])
  end

end
