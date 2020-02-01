ExUnit.start

defmodule AnonymousFunctionsTest do
  use ExUnit.Case

  test "map" do
    assert Enum.map([1,2,3], fn(x) -> x * 2 end) == [2,4,6]
  end
end
