defmodule AubergeTest do
  use ExUnit.Case
  use Maru.Test, for: Auberge.API.V1.Customers

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "/customers" do
    assert "hello" = get("/customers/1") |> json_response
  end
end
