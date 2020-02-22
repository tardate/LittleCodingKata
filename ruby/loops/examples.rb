#! /usr/bin/env ruby
require 'minitest/autorun'

class TestLoops < Minitest::Test
  EXPECTED = 5
  DOUBLE_EXPECTED = 2 * EXPECTED

  def test_for
    for i in 0..EXPECTED
      result = i
    end
    assert_equal EXPECTED, result
  end

  def test_for_with_break
    for i in 0..DOUBLE_EXPECTED
      result = i
      break if result == EXPECTED
    end
    assert_equal EXPECTED, result
  end

  def test_each
    result = 0
    (0..EXPECTED).each do |i|
      result = i
    end
    assert_equal EXPECTED, result
  end

  def test_each_with_break
    result = 0
    (0..DOUBLE_EXPECTED).each do |i|
      result = i
      break if result == EXPECTED
    end
    assert_equal EXPECTED, result
  end

  def test_loop
    result = 0
    loop do
      result += 1
      break if result == EXPECTED
    end
    assert_equal EXPECTED, result
  end

  def test_while
    result = 0
    while result < EXPECTED do
      result += 1
    end
    assert_equal EXPECTED, result
  end

  def test_until
    result = 0
    until result == EXPECTED do
      result += 1
    end
    assert_equal EXPECTED, result
  end

  def test_while_modifier
    result = 0
    begin
      result += 1
    end while result < EXPECTED
    assert_equal EXPECTED, result
  end

  def test_while_modifier_short_form
    result = 0
    result += 1 while result < EXPECTED
    assert_equal EXPECTED, result
  end

  def test_until_modifier
    result = 0
    begin
      result += 1
    end until result == EXPECTED
    assert_equal EXPECTED, result
  end

  def test_until_modifier_short_form
    result = 0
    result += 1 until result == EXPECTED
    assert_equal EXPECTED, result
  end
end
