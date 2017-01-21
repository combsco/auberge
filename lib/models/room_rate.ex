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

defmodule Auberge.RoomRate do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset

  schema "room_rates" do
    field :description, :string         # Rack
    field :code, :string                # RACKMF
    field :type, :string                # Unused
    field :starts_at, :date             # 2016-02-01
    field :ends_at, :date               # 9999-02-01
    field :days_of_week, :map           # {"Monday": true}
    field :min_stay, :integer           # 1
    field :max_stay, :integer           # 7
    field :min_occupancy, :integer      # 1
    field :max_occupancy, :integer      # 2
    field :extra_adult_price, :decimal  # 199.00
    field :extra_child_price, :decimal  # 59.00
    field :price, :decimal              # 261.00

    timestamps()
    # field :deleted_at, :utc_datetime

    many_to_many :types, Auberge.RoomType, join_through: "room_rates_types"
  end

  @required_params ~w(description code starts_at ends_at days_of_week min_stay max_stay min_occupancy max_occupancy price)
  @optional_params ~w(type extra_adult_price extra_child_price)

  def changeset(room_rate, params \\ :empty) do
    room_rate
    |> cast(params, @required_params, @optional_params)
  end
end
