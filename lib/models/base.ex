defmodule Auberge.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime, usec: false]
    end
  end
end
