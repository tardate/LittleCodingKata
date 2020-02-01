ExUnit.start

defmodule PatternMatchingTest do
  use ExUnit.Case

  test "= is a matcher" do
    a = 1
    assert 1 = a
    assert a == 1
  end

  test "matching a list" do
    list = [1, 2, 3]
    [a, b, c] = list
    assert a == 1
    assert b == 2
    assert c == 3
  end

  test "matching nested list" do
    [a, b, c] = [1, 2, [3, 4, 5]]
    assert a == 1
    assert b == 2
    assert c == [3, 4, 5]
  end

  test "partial matching a list" do
    [_, _, c] = [1, 2, 3]
    assert c == 3
  end

  test "match on ranges" do
    a..b = 1..10
    assert a == 1
    assert b == 10
  end

  test "variables can only bind once per match" do
    [a, a] = [1, 1]
    assert a == 1
    assert_raise MatchError, fn ->
      [b, b] = [1, 2]
    end
  end

  test "valid matches" do
    a = [1, 2, 3]
    assert a == [1, 2, 3]
    a = [[1,2,3]]
    assert a == [[1,2,3]]
    [a..5] = [1..5]
    assert a == 1
    [a] = [[1,2,3]]
    assert a == [1,2,3]
  end

  test "use existing value in match" do
    a = 1
    [^a, 2] = [1, 2]
    assert a == 1
    assert_raise MatchError, fn ->
      [^a, 2] = [2, 2]
    end
  end
end
