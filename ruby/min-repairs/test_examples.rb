#!/usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = [
    [1, 0, 0, 1],
    [1, 0, 0, 1],
    [1, 1, 0, 1],
    [0, 1, 1, 1]
  ]
  EG1_k = 2
  EG1_EXPECTED = 2

  EG2 = [
    [1, 0, 0, 1],
    [1, 0, 0, 1],
    [1, 1, 0, 1],
    [0, 0, 1, 1]
  ]
  EG2_k = 1
  EG2_EXPECTED = 3

  def exec_test_case(algorithm, given=EG1, k=EG1_k, expected=EG1_EXPECTED)
    result = Repairer.new(given, k).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_with_example_1
    exec_test_case(:minRepairs)
  end

  def test_with_example_2
    exec_test_case(:minRepairs, EG2, EG2_k, EG2_EXPECTED)
  end
end
