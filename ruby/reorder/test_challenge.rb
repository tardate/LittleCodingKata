#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestReorder < Minitest::Test
  def exec_test_case(algorithm, input, sequence, expected)
    calculator = Reorder.new(input, sequence)
    result = calculator.send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_default_algorithm_given_example
    exec_test_case(
      'default',
      ['C', 'D', 'E', 'F', 'G', 'H'],
      [3, 0, 4, 1, 2, 5],
      ['D', 'F', 'G', 'C', 'E', 'H']
    )
  end

  def test_non_mutating_algorithm_given_example
    exec_test_case(
      'non_mutating',
      ['C', 'D', 'E', 'F', 'G', 'H'],
      [3, 0, 4, 1, 2, 5],
      ['D', 'F', 'G', 'C', 'E', 'H']
    )
  end

  def test_mutating_simple_algorithm_given_example
    exec_test_case(
      'mutating_simple',
      ['C', 'D', 'E', 'F', 'G', 'H'],
      [3, 0, 4, 1, 2, 5],
      ['D', 'F', 'G', 'C', 'E', 'H']
    )
  end

  def test_mutating_cyclic_algorithm_given_example
    exec_test_case(
      'mutating_cyclic',
      ['C', 'D', 'E', 'F', 'G', 'H'],
      [3, 0, 4, 1, 2, 5],
      ['D', 'F', 'G', 'C', 'E', 'H']
    )
  end
end
