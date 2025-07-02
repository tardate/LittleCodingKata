#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = 'candy canes do taste yummy'
  EG1_EXPECTED = 'u'

  EG2 = 'candy canes yummy candy canes yummy'
  EG2_EXPECTED = nil

  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = LastNonRepeatingCharacter.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_copilot_suggested
    exec_test_case(:copilot_suggested)
  end

  def test_copilot_suggested_unmatched
    exec_test_case(:copilot_suggested, EG2, EG2_EXPECTED)
  end

  def test_idiomatic_ruby_by_copilot
    exec_test_case(:idiomatic_ruby_by_copilot)
  end

  def test_idiomatic_ruby_by_copilot_unmatched
    exec_test_case(:idiomatic_ruby_by_copilot, EG2, EG2_EXPECTED)
  end

  def test_one_liner
    exec_test_case(:one_liner)
  end

  def test_one_liner_unmatched
    exec_test_case(:one_liner, EG2, EG2_EXPECTED)
  end
end
