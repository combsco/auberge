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
  import Ecto.Query

  @derive {Poison.Encoder, only: [:id, :name, :short_code, :type, :starts_at, :ends_at,
                                  :effective_days, :min_stay, :max_stay,
                                  :min_occupancy, :max_occupancy, :extra_adult_price,
                                  :extra_child_price, :price, :price_model, :status]}

  schema "room_rates" do
    field :name, :string                                # Rack
    field :short_code, :string                          # RACKMF
    field :type, :string                                # Unused, maybe a priority type deal?
    field :starts_at, :date                             # 2016-02-01
    field :ends_at, :date                               # 9999-02-01
    embeds_one :effective_days, EffectiveOnDays, primary_key: false do
      field :monday, :boolean                           # true
      field :tuesday, :boolean                          # true
      field :wednesday, :boolean                        # true
      field :thursday, :boolean                         # true
      field :friday, :boolean                           # true
      field :saturday, :boolean                         # true
      field :sunday, :boolean                           # true
    end
    field :min_stay, :integer, default: 1               # 1 (nights)
    field :max_stay, :integer, default: 7               # 7 (nights)
    field :min_occupancy, :integer, default: 1          # 1
    field :max_occupancy, :integer, default: 2          # 2
    field :extra_adult_price, :decimal, default: 0.00   # 199.00
    field :extra_child_price, :decimal, default: 0.00   # 59.00
    field :price, :decimal, default: 1.00               # 261.00
    field :price_model, :string, default:  "PerDay"     # PerDay
    field :status, :string, default: "active"           # active

    field :created_by, :string          # chrisc
    field :updated_by, :string          # chrisc
    timestamps()

    many_to_many :types, Auberge.RoomType, join_through: "room_rates_types"
  end

  def changeset(rate, params \\ :empty) do
    rate
    |> cast(params, [:id, :name, :short_code, :type, :starts_at, :ends_at,
                     :min_stay, :max_stay, :min_occupancy, :max_occupancy,
                     :extra_adult_price, :extra_child_price, :price,
                     :price_model, :status])
    |> cast_embed(:effective_days, with: &effective_days_changeset/2, required: true)
    |> validate_required([:name, :short_code, :type, :starts_at, :ends_at])
    |> validate_length(:name, max: 30)
    |> validate_length(:short_code, max: 30)
    |> validate_length(:type, max: 30)
    |> validate_number(:min_stay, greater_than_or_equal_to: 0)
    |> validate_number(:max_stay, greater_than_or_equal_to: 0)
    |> validate_number(:min_occupancy, greater_than_or_equal_to: 0)
    |> validate_number(:max_occupancy, greater_than_or_equal_to: 0)
    |> validate_number(:extra_adult_price, greater_than_or_equal_to: 0)
    |> validate_number(:extra_child_price, greater_than_or_equal_to: 0)
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> validate_length(:price_model, max: 30)
    |> validate_inclusion(:status, ["active", "inactive"])
  end

  defp effective_days_changeset(ed, params) do
    ed
    |> cast(params, [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday])
    |> validate_required([:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday])
  end

  def get_by_uuid(query, uuid) do
    from rr in query,
    where: rr.id == ^uuid
  end

end
