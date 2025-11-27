#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = [
    ["Make Gravy", 10, 11],
    ["Mash Potatoes", 11, 12],
    ["Bake Rolls", 11, 13],
    ["Prep Salad", 12, 13]
  ]
  EG1_EXPECTED = {
    count: 3,
    chosen: ["Make Gravy", "Mash Potatoes", "Prep Salad"]
  }

  EG2 = [
    ["Mash Potatoes", 10, 12],
    ["Make Gravy", 10, 11],
    ["Bake Rolls", 14, 16],
    ["Prep Salad", 14, 15]
  ]
  EG2_EXPECTED = {
    count: 2,
    chosen: ["Make Gravy", "Prep Salad"]
  }

  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = MealPlanner.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_spt_with_example_1
    exec_test_case(:minAssemblyTime)
  end

  def test_spt_with_example_2
    exec_test_case(:minAssemblyTime, EG2, EG2_EXPECTED)
  end
end
