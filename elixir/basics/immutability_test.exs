ExUnit.start

defmodule ImmutabilityTest do
  use ExUnit.Case

  test "capitalize does not modify original string" do
    name = "elixir"
    upname = String.capitalize name
    assert upname == "Elixir"
    assert name == "elixir"
  end
end
