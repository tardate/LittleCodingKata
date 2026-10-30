#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestChallenge < Minitest::Test
  def exec_test_case(given, expected)
    result = halloweenSwap(given)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1
    exec_test_case([0, 1, 2, 3], 0)
  end

  def test_example2
    exec_test_case([1, 2, 0], 2)
  end

  def test_example3
    exec_test_case([4, 3, 2, 1, 0], 2)
  end

  def test_example4
    exec_test_case([2, 3, 4, 0, 1], 4)
  end
end
