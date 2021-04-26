#! /usr/bin/env ruby
require 'minitest/autorun'

class TestBitwizeOperations < Minitest::Test
  def test_to_s
    given = 0b01010101
    expected = '1010101'
    assert_equal expected, given.to_s(2)
  end

  def test_not_returns_signed_int32
    given = 0b0101
    expected_signed = -0b110
    expected_to_s = '11111111111111111111111111111010'
    assert_equal expected_signed, ~given
    assert_equal expected_to_s, (~given & 0xFFFF_FFFF).to_s(2)
  end

  def test_and
    result = 0b0101 & 0b0110
    expected = 0b0100
    assert_equal expected, result
  end

  def test_or
    result = 0b0101 | 0b0110
    expected = 0b0111
    assert_equal expected, result
  end

  def test_xor
    result = 0b0101 ^ 0b0110
    expected = 0b0011
    assert_equal expected, result
  end

  def test_shift_left
    result = 0b0101 << 2
    expected = 0b010100
    assert_equal expected, result
  end

  def test_shift_right
    result = 0b0101 >> 2
    expected = 0b01
    assert_equal expected, result
  end
end
