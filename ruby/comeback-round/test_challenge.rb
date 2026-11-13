#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestComebackRound < Minitest::Test
  def exec_test_case(given, expected)
    result = comebackRound(given)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1
    exec_test_case(
      [
        [5, 3, 2],
        [0, 5, 2],
        [4, 2, 2],
        [1, 3, 0]
      ],
      2
    )
  end

  def test_example2
    exec_test_case(
      [
        [4, 2],
        [1, 3],
        [2, 1]
      ],
      3
    )
  end

  def test_example3
    exec_test_case(
      [
        [4, 2],
        [1, 3],
      ],
      -1
    )
  end
end


class TestComebackRoundDualPass < Minitest::Test
  def exec_test_case(given, expected)
    result = comebackRoundDualPass(given)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1
    exec_test_case(
      [
        [5, 3, 2],
        [0, 5, 2],
        [4, 2, 2],
        [1, 3, 0]
      ],
      2
    )
  end

  def test_example2
    exec_test_case(
      [
        [4, 2],
        [1, 3],
        [2, 1]
      ],
      3
    )
  end

  def test_example3
    exec_test_case(
      [
        [4, 2],
        [1, 3],
      ],
      -1
    )
  end
end
