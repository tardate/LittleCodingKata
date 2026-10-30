#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestChallenge < Minitest::Test
  def exec_test_case(given, expected)
    calculator = Challenge.new(given)
    result = calculator.result
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1
    exec_test_case("given", "expected")
  end
end
