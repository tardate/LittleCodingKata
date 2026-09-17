#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestChallenge < Minitest::Test
  def exec_test_case(sentence, expected)
    calculator = Challenge.new(sentence)
    result = calculator.longestSorted
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1
    exec_test_case("The autumn leaves almost glow.", "almost")
  end

  def test_example1b
    exec_test_case("Almost as the autumn leaves ALMOST glow.", "almost")
  end

  def test_example1c
    exec_test_case("The autumn leaves glow almost.", "almost")
  end

  def test_example2
    exec_test_case("A cool sheep sleeps.", "")
  end
end
