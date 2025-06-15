#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1_ARR1 = [9, 14, 6, 2, 11]
  EG1_ARR2 = [8, 4, 7, 20]
  EG1_EXPECTED = [[9, 8], [9, 4], [9, 20], [14, 7], [6, 7], [2, 7], [11, 8], [11, 4], [11, 20]]

  EG2_ARR1 = [2, 4, 6, 8]
  EG2_ARR2 = [10, 12, 14]
  EG2_EXPECTED = nil

  def test_chat_gpt_a
    calculator = OddSumCalculator.new(EG1_ARR1, EG1_ARR2)
    result = calculator.chat_gpt_a
    assert_equal EG1_EXPECTED, result
  end

  def test_chat_gpt_a_unmatched
    calculator = OddSumCalculator.new(EG2_ARR1, EG2_ARR2)
    result = calculator.chat_gpt_a
    assert_nil result
  end

  def test_chat_gpt_a_optimised
    calculator = OddSumCalculator.new(EG1_ARR1, EG1_ARR2)
    result = calculator.chat_gpt_a_optimised
    assert_equal EG1_EXPECTED.sort, result.sort
  end

  def test_chat_gpt_a_optimised_unmatched
    calculator = OddSumCalculator.new(EG2_ARR1, EG2_ARR2)
    result = calculator.chat_gpt_a_optimised
    assert_nil result
  end

  def test_deepseek_a
    calculator = OddSumCalculator.new(EG1_ARR1, EG1_ARR2)
    result = calculator.deepseek_a
    assert_equal EG1_EXPECTED.sort, result.sort
  end

  def test_deepseek_a_unmatched
    calculator = OddSumCalculator.new(EG2_ARR1, EG2_ARR2)
    result = calculator.deepseek_a
    assert_nil result
  end
end
