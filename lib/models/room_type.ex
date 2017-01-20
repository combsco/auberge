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
