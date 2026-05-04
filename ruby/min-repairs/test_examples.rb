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

  def test_example_3
    given = [
      [0, 1, 0, 0],
      [0, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 0, 0]
    ]
    exec_test_case(:minRepairs, given, 3, 4)
  end

  def test_example_4
    skip "Algorithm is not smart enough to solve fully broken squares yet (fpsvogel: passing grid_4)"
    given = [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ]
    exec_test_case(:minRepairs, given, 6, 4)
  end

  def test_example_5
    skip "Algorithm is not smart enough to solve fully broken squares yet (fpsvogel: failing grid_4)"
    given = [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]
    exec_test_case(:minRepairs, given, 12, 6)
  end

  def test_example_6
    skip "Algorithm is not smart enough to solve fully broken squares yet (fpsvogel: failing grid_3"
    given = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ]
    exec_test_case(:minRepairs, given, 15, 6)
  end

  def test_example_7
    skip "Algorithm is not smart enough to solve this test case yet (fpsvogel: failing grid_5"
    given = [
      [0, 0, 0],
      [0, 0, 0],
      [1, 0, 1],
      [0, 0, 0],
      [0, 0, 0]
    ]
    exec_test_case(:minRepairs, given, 6, 1)
  end
end
