#! /usr/bin/env ruby
require 'minitest/autorun'
require './example'


class TestExample < Minitest::Test
  def exec_test_case(grid_width, grid_height, size, center_x, center_y, expected)
    result = getImpactedCoordinates(grid_width, grid_height, size, center_x, center_y)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example_1
    exec_test_case(5, 5, 3, 1, 1, [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]])
  end

  def test_example_2
    exec_test_case(3, 3, 1, 2, 1, [[2,1]])
  end

  def test_example_3
    exec_test_case(5, 5, 3, 4, 4, [[3,3],[3,4],[4,3],[4,4]])
  end
end
