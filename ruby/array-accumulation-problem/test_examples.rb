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

  def test_improved2a_empty_array
    exec_test_case(:improved2a)
  end

  def test_improved2a_single_element
    exec_test_case(:improved2a, EG2, EG2_EXPECTED)
  end

  def test_improved2a_two_elements
    exec_test_case(:improved2a, EG3, EG3_EXPECTED)
  end

  def test_improved2a_three_elements
    exec_test_case(:improved2a, EG4, EG4_EXPECTED)
  end

  def test_improved2a_four_elements
    exec_test_case(:improved2a, EG5, EG5_EXPECTED)
  end

  def test_improved2a_negative_elements
    exec_test_case(:improved2a, EG6, EG6_EXPECTED)
  end

  def test_improved2a_float_elements
    result = ArrayAccumulationProblem.new(EG7).send(:improved2a)
    assert_in_delta EG7_EXPECTED, result, 0.01
    refute_equal EG7_EXPECTED, result   # sanity check
  end

  def test_improved2a_mixed_elements
    exec_test_case(:improved2a, EG8, EG8_EXPECTED)
  end

  def test_improved2b_empty_array
    exec_test_case(:improved2b)
  end

  def test_improved2b_single_element
    exec_test_case(:improved2b, EG2, EG2_EXPECTED)
  end

  def test_improved2b_two_elements
    exec_test_case(:improved2b, EG3, EG3_EXPECTED)
  end

  def test_improved2b_three_elements
    exec_test_case(:improved2b, EG4, EG4_EXPECTED)
  end

  def test_improved2b_four_elements
    exec_test_case(:improved2b, EG5, EG5_EXPECTED)
  end

  def test_improved2b_negative_elements
    exec_test_case(:improved2b, EG6, EG6_EXPECTED)
  end

  def test_improved2b_float_elements
    exec_test_case(:improved2b, EG7, EG7_EXPECTED)
  end

  def test_improved2b_mixed_elements
    exec_test_case(:improved2b, EG8, EG8_EXPECTED)
  end
end
