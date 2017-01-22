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
    field :type, :string                  # Guest
    field :class, :string                 # Standard
    field :view, :string                  # City View
    field :max_adults, :integer            # 4
    field :max_children, :integer            # 3

    embeds_one :bedding, Bedding, primary_key: false do
      field :type, :string                # Double
      field :quantity, :integer           # 2
    end

    embeds_many :extra_bedding, ExtraBedding do
      field :type, :string                # Rollaway Bed
      field :quantity, :integer           # 1
      field :frequency, :string         # Per Day, One-time, Per Week
      field :surcharge, :decimal           # 20.00
    end

    field :smoking, :boolean              # false
    field :status, :string                # active

    field :created_by, :string            # chrisc
    field :updated_by, :string            # chrisc
    timestamps()

    has_many :rooms, Auberge.Room
    many_to_many :rates, Auberge.RoomRate, join_through: "room_rates_types"
  end

  def changeset(room_type, params \\ :empty) do
    room_type
    |> cast(params, [:description, :num_of_beds, :type_of_beds])
  end
end
