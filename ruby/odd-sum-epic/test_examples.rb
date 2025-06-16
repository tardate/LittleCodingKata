#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1_ARR1 = [9, 14, 6, 2, 11]
  EG1_ARR2 = [8, 4, 7, 20]
  EG1_EXPECTED = [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]
  EG1_ALT_EXPECTED = [[9, 20], [14, 7], [11,8]]

  EG2_ARR1 = [2, 4, 6, 8]
  EG2_ARR2 = [10, 12, 14]
  EG2_EXPECTED = nil

  def exec_eg1(algorithm, expected=EG1_EXPECTED)
    calculator = OddSumCalculator.new(EG1_ARR1, EG1_ARR2)
    result = calculator.send(algorithm)
    assert_equal expected.sort, result.sort
  end

  def exec_eg2(algorithm, expected=EG2_EXPECTED)
    calculator = OddSumCalculator.new(EG2_ARR1, EG2_ARR2)
    result = calculator.send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_chat_gpt_a
    exec_eg1(:chat_gpt_a)
  end

  def test_chat_gpt_a_unmatched
    exec_eg2(:chat_gpt_a)
  end

  def test_chat_gpt_a_optimised
    exec_eg1(:chat_gpt_a_optimised)
  end

  def test_chat_gpt_a_optimised_unmatched
    exec_eg2(:chat_gpt_a_optimised)
  end

  def test_deepseek_a
    exec_eg1(:deepseek_a)
  end

  def test_deepseek_a_unmatched
    exec_eg2(:deepseek_a)
  end

  def test_andy_a
    exec_eg1(:andy_a)
  end

  def test_andy_a_unmatched
    exec_eg2(:andy_a, [])
  end

  def test_andy_b
    skip "Expected failure: andy_b reverses pairs that have an even number from array a and an odd number from array b"
    exec_eg1(:andy_b)
  end

  def test_andy_b_unmatched
    exec_eg2(:andy_b, [])
  end

  def test_andy_b_fixed
    exec_eg1(:andy_b_fixed)
  end

  def test_andy_b_fixed_unmatched
    exec_eg2(:andy_b_fixed, [])
  end

  def test_andy_c
    exec_eg1(:andy_c)
  end

  def test_andy_c_unmatched
    exec_eg2(:andy_c, [])
  end

  def test_andy_d
    skip "Expected failure: andy_d reverses pairs that have an even number from array a and an odd number from array b"
    exec_eg1(:andy_d)
  end

  def test_andy_d_unmatched
    exec_eg2(:andy_d, [])
  end

  def test_andy_d_fixed
    exec_eg1(:andy_d_fixed)
  end

  def test_andy_d_fixed_unmatched
    exec_eg2(:andy_d_fixed, [])
  end

  def test_examples_rule
    exec_eg1(:examples_rule, EG1_ALT_EXPECTED)
  end

  def test_examples_rule_unmatched
    exec_eg2(:examples_rule)
  end
end
