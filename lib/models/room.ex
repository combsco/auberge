# Copyright 2017 Christopher Combs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

defmodule Auberge.Room do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:room_num, :floor_num, :size_sqm]}

  schema "rooms" do
    field :room_num, :string            # 701A
    field :floor_num, :integer          # 7
    field :size_sqm, :decimal           # 27.8

    field :created_by, :string  # chrisc
    field :updated_by, :string  # chrisc
    timestamps()

    belongs_to :property, Auberge.Property
    belongs_to :room_type, Auberge.RoomType
  end

  def changeset(room, params \\ :empty) do
      room
      |> cast(params, [:room_num, :floor_num])
  end

end
