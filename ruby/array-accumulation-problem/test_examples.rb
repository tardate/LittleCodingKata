#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = []
  EG1_EXPECTED = 0

  EG2 = [1]
  EG2_EXPECTED = 1

  EG3 = [1, 4]
  EG3_EXPECTED = 10

  EG4 = [1, 4, 7]
  EG4_EXPECTED = 28

  EG5 = [1, 4, 7, 10]
  EG5_EXPECTED = 55

  EG6 = [-1, -2, -3]
  EG6_EXPECTED = -14

  EG7 = [0.1, 0.2, 0.3]
  EG7_EXPECTED = 1.4

  EG8 = [1,-20,300,-4000,50000,-600000,7000000]
  EG8_EXPECTED = 12338842

  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = ArrayAccumulationProblem.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_default_empty_array
    exec_test_case(:default)
  end

  def test_default_single_element
    exec_test_case(:default, EG2, EG2_EXPECTED)
  end

  def test_default_two_elements
    exec_test_case(:default, EG3, EG3_EXPECTED)
  end

  def test_default_three_elements
    exec_test_case(:default, EG4, EG4_EXPECTED)
  end

  def test_default_four_elements
    exec_test_case(:default, EG5, EG5_EXPECTED)
  end

  def test_default_negative_elements
    exec_test_case(:default, EG6, EG6_EXPECTED)
  end

  def test_default_float_elements
    exec_test_case(:default, EG7, EG7_EXPECTED)
  end

  def test_default_mixed_elements
    exec_test_case(:default, EG8, EG8_EXPECTED)
  end

  def test_improved_empty_array
    exec_test_case(:improved)
  end

  def test_improved_single_element
    exec_test_case(:improved, EG2, EG2_EXPECTED)
  end

  def test_improved_two_elements
    exec_test_case(:improved, EG3, EG3_EXPECTED)
  end

  def test_improved_three_elements
    exec_test_case(:improved, EG4, EG4_EXPECTED)
  end

  def test_improved_four_elements
    exec_test_case(:improved, EG5, EG5_EXPECTED)
  end

  def test_improved_negative_elements
    exec_test_case(:improved, EG6, EG6_EXPECTED)
  end

  def test_improved_float_elements
    exec_test_case(:improved, EG7, EG7_EXPECTED)
  end

  def test_improved_mixed_elements
    exec_test_case(:improved, EG8, EG8_EXPECTED)
  end
end
