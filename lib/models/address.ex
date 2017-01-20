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

defmodule Auberge.Address do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :premise, :string             # Apt 201
    field :throughfare, :string         # 284 Race Avenue
    field :locality, :string            # East Strousburg
    field :administrative_area, :string # PA
    field :postal_code, :string         # 18301
    field :country, :string             # USA
  end

  @required_params ~w(throughfare locality administrative_area postal_code country)a

  def changeset(address, params \\ :empty) do
    address
    |> cast(params, [:throughfare, :locality, :administrative_area, :postal_code, :country])
    |> validate_required(@required_params)
  end
end
