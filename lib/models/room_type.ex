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
  import Ecto.Query

  @derive {Poison.Encoder, only: [:id, :type, :class, :view, :max_adults, :max_children,
                                  :bedding, :extra_bedding, :smoking, :status, :rates,
                                  :created_at, :updated_at]}

  schema "room_types" do
    field :type, :string                          # Guest
    field :class, :string                         # Standard
    field :view, :string                          # City View
    field :max_adults, :integer, default: 2       # 4
    field :max_children, :integer, default: 2     # 3

    embeds_one :bedding, Bedding, primary_key: false do
      field :type, :string                        # Double
      field :quantity, :integer                   # 2
    end

    embeds_many :extra_bedding, ExtraBedding do
      field :type, :string                        # Rollaway Bed
      field :quantity, :integer                   # 1
      field :frequency, :string                   # Per Day, One-time, Per Week
      field :surcharge, :decimal                  # 20.00
    end

    field :smoking, :boolean, default: false      # false
    field :status, :string, default: "active"     # active

    field :created_by, :string                    # chrisc
    field :updated_by, :string                    # chrisc
    timestamps()

    has_many :rooms, Auberge.Room
    many_to_many :rates, Auberge.RoomRate, join_through: "room_rates_types"
  end

  def changeset(type, params \\ :empty) do
    type
    |> cast(params, [:type, :class, :view, :max_adults, :max_children,
                     :smoking, :status, :created_at, :updated_at])
    |> cast_embed(:bedding, with: &bedding_changeset/2, required: true)
    |> cast_embed(:extra_bedding, with: &extra_bedding_changeset/2, required: false)
    |> validate_required([:type, :class, :bedding])
    |> validate_length(:type, max: 30)
    |> validate_length(:class, max: 30)
    |> validate_length(:view, max: 30)
    |> validate_number(:max_adults, greater_than_or_equal_to: 0)
    |> validate_number(:max_children, greater_than_or_equal_to: 0)
    |> validate_inclusion(:status, ["active", "inactive"])
  end

  defp bedding_changeset(type, params) do
    type
    |> cast(params, [:type, :quantity])
    |> validate_required([:type, :quantity])
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
  end

  # FIXME - How to identify the array to modify?
  defp extra_bedding_changeset(type, params) do
    type
    |> cast(params, [:type, :quantity, :frequency, :surcharge])
    |> validate_required([:type, :quantity, :frequency, :surcharge])
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> validate_number(:surcharge, greater_than_or_equal_to: 0)
  end

  def get_by_uuid(query, uuid) do
    from rt in query,
    where: rt.id == ^uuid
  end
end
