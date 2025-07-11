#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = [
    {"height" => 10, "size" => 6, "velocity" => 4},
    {"height" => 13, "size" => 3, "velocity" => 2},
    {"height" => 17, "size" => 6, "velocity" => 3},
    {"height" => 21, "size" => 8, "velocity" => 4},
    {"height" => 19, "size" => 5, "velocity" => 3},
    {"height" => 18, "size" => 4, "velocity" => 4}
  ]
  EG1_EXPECTED = 2
  EG_SKEWED_AVERAGE = [
    {"height" => 1, "size" => 5, "velocity" => 3},
    {"height" => 1, "size" => 1, "velocity" => 3},
    {"height" => 1, "size" => 1, "velocity" => 3},
    {"height" => 1, "size" => 1, "velocity" => 3},
    {"height" => 1, "size" => 2, "velocity" => 3},
    {"height" => 1, "size" => 50, "velocity" => 3},
    {"height" => 1, "size" => 3, "velocity" => 3}
  ]
  EG_SKEWED_AVERAGE_EXPECTED = 0

  EG_VELOCITY_LOW = [
    {"height" => 1, "size" => 5, "velocity" => 2}
  ]
  EG_VELOCITY_LOW_EXPECTED = nil

  EG_VELOCITY_HIGH = [
    {"height" => 1, "size" => 5, "velocity" => 4}
  ]
  EG_VELOCITY_HIGH_EXPECTED = nil

  EG_HEIGHT_EXCEEDED = [
    {"height" => 10, "size" => 5, "velocity" => 3},
    {"height" => 21, "size" => 5, "velocity" => 3},
    {"height" => 12, "size" => 5, "velocity" => 3}
  ]
  EG_HEIGHT_EXCEEDED_EXPECTED = 1


  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = GrandFinale.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_initial_solution
    exec_test_case(:initial_solution)
  end

  def test_initial_solution_handles_skewed_average
    exec_test_case(:initial_solution, EG_SKEWED_AVERAGE, EG_SKEWED_AVERAGE_EXPECTED)
  end

  def test_initial_solution_handles_velocity_too_low
    exec_test_case(:initial_solution, EG_VELOCITY_LOW, EG_VELOCITY_LOW_EXPECTED)
  end

  def test_initial_solution_handles_velocity_too_high
    exec_test_case(:initial_solution, EG_VELOCITY_HIGH, EG_VELOCITY_HIGH_EXPECTED)
  end
  def test_initial_solution_handles_height_exceeded
    exec_test_case(:initial_solution, EG_HEIGHT_EXCEEDED, EG_HEIGHT_EXCEEDED_EXPECTED)
  end
end
