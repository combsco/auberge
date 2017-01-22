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

defmodule Auberge.Customer do
  @moduledoc false
  use Auberge.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Auberge.Address

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :phone_num, :email, :inserted_at, :updated_at]}

  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :phone_num, :string
    field :email, :string
    embeds_many :address, Address

    field :created_by, :string  # chrisc
    field :updated_by, :string  # chrisc
    timestamps()
  end

  def changeset(customer, params \\ :empty) do
    customer
    |> cast(params, [:first_name, :last_name, :phone_num, :email])
    |> validate_required([:first_name, :last_name, :email])
    |> validate_length(:first_name, min: 2, max: 30)
    |> validate_length(:last_name, min: 2, max: 30)
    |> validate_length(:phone_num, max: 15)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:email, max: 254)
    |> unique_constraint(:email)
  end

  def get_by_uuid(query, uuid) do
    from c in query,
    where: c.id == ^uuid
  end
end
