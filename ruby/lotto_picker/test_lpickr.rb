#! /usr/bin/env ruby
require 'minitest/autorun'
require './lpickr'

class LottoPickerTest < Minitest::Test
  def test_returns_expected_number_of_numbers
    assert_equal 1, pick(1, 40).length
    assert_equal 6, pick(6, 40).length
    assert_equal 12, pick(12, 40).length
  end

  def test_returns_all_numbers_within_range
    100.times do
      result = pick(1, 10)
      assert_equal 1, result.length
      assert result.first.between?(1, 10)
    end
  end

  def test_fails_if_ask_for_more_numbers_than_available
    assert_raises(StandardError) do
      pick(6, 5)
    end
  end

  def test_empty_if_ask_for_zero
    assert_equal 0, pick(0, 0).length
  end
end
