ExUnit.start

defmodule StringsAndBinariesTest do
  use ExUnit.Case

  test "allow interpolation" do
    name = "Dave"
    assert "Hello, #{name}" == "Hello, Dave"
  end

  test "character list without interpolation" do
    assert ~C[1\n2#{1+2}] == '1\\n2\#{1+2}'
  end

  test "character list with interpolation" do
    assert ~c[1\n2#{1+2}] == '1\n23'
  end

  test "binary string without interpolation" do
    assert ~S[1\n2#{1+2}] == "1\\n2\#{1+2}"
  end

  test "binary string with interpolation" do
    assert ~s[1\n2#{1+2}] == "1\n23"
  end

  test "whitespace-delimited words, with no escaping or interpolation" do
    assert ~W[dog c#{'a'}t budgie] == ["dog", "c\#{'a'}t", "budgie"]
  end

  test "whitespace-delimited words, with escaping and interpolation" do
    assert ~w[dog c#{'a'}t budgie] == ["dog", "cat", "budgie"]
  end

  test "single-quoted strings are lists" do
    assert is_list('abc')
  end

  test "double-quoted strings are binaries" do
    assert is_binary("abc")
  end

  test "convert binary to list" do
    # in previous versions this was done with `binary_to_list`
    assert String.to_charlist("abc") == 'abc'
  end

  test "UTF-8 can take more than one byte per character" do
    dqs = "∂x/∂y"
    assert String.length(dqs) == 5
    assert byte_size(dqs) == 9
  end
end
