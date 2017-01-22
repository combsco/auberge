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

defmodule Auberge.Property do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Auberge.Address
  alias Auberge.Room

  @derive {Poison.Encoder, only: [:id, :name, :address, :inserted_at, :updated_at]}

  schema "properties" do
    field :name, :string        # Ovalii Hotel & Suites
    embeds_one :address, Address
    field :cancellation_time    # 18:00
    embeds_one :reservation_cutoff, ReservationCutoff, primary_key: false do
      field :time, :string      # 05:00
      field :day, :string       # same
    end
    field :currency, :string    # USD (ISO 4217)
    field :tz, :string          # America/New_York
    field :status, :string      # active

    field :created_by, :string  # chrisc
    field :updated_by, :string  # chrisc
    timestamps()

    has_many :rooms, Room
  end

  def changeset(property, params \\ :empty) do
    property
    |> cast(params, [:name])
    |> cast_embed(:address, required: false)
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 30)
  end

  def get_by_uuid(query, uuid) do
    from p in query,
    where: p.id == ^uuid
  end
end

# defimpl Poison.Encoder, for: Auberge.Property do
#   @attributes ~w(name address inserted_at updated_at)a
#
#   def encode(property, options) do
#     IO.inspect property
#
#     property
#     |> Map.take(@attributes)
#     |> Poison.Encoder.encode(options)
#   end
# end
