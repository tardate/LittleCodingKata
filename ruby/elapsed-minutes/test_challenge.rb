#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestToMinutes < Minitest::Test
  def exec_test_case(given, expected)
    result = to_minutes(given)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_minutes_only
    exec_test_case("00:51", 51)
  end

  def test_hours_and_minutes
    exec_test_case("01:55", 115)
  end
end


class TestChallenge < Minitest::Test
  def exec_test_case(given, expected, algorithm = 'default')
    calculator = Challenge.new(given)
    result = calculator.send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_example1_raw
    exec_test_case(["00:50", "01:10", "01:50", "01:10", "02:10"], 140)
    exec_test_case(["00:50", "01:10", "01:50", "01:10", "02:10"], 140, 'raw')
  end

  def test_example2_raw
    exec_test_case(["01:55", "01:05", "01:25", "01:40"], 45)
    exec_test_case(["01:55", "01:05", "01:25", "01:40"], 45, 'raw')
  end

  def test_example1_using_time_class
    exec_test_case(["00:50", "01:10", "01:50", "01:10", "02:10"], 140, 'using_time_class')
  end

  def test_example2_using_time_class
    exec_test_case(["01:55", "01:05", "01:25", "01:40"], 45, 'using_time_class')
  end
end
