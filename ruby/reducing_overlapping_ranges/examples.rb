#! /usr/bin/env ruby
require 'minitest/autorun'
require 'range_operators'

class RangeReductionTest < Minitest::Test
  # NB: data sets and calculations assume inclusive of start and end

  def basic_overlapping_integers
    [
      [5, 10], # => covers 6
      [8, 12], # => partial cover, add another 2
      [6, 8],  # => fully covered, so no accumulation
      [20, 22] # => no overlap, so add 3
    ]
  end

  def basic_overlapping_integers_expected_result
    6 + 2 + 3
  end

  def basic_overlapping_time_values
    [
      [Time.utc(2021, 2, 1, 11, 00).to_i, Time.utc(2021, 2, 1, 12, 00).to_i], # => covers 3601
      [Time.utc(2021, 2, 1, 11, 30).to_i, Time.utc(2021, 2, 1, 11, 45).to_i], # => fully covered, so no accumulation
      [Time.utc(2021, 2, 1, 11, 15).to_i, Time.utc(2021, 2, 1, 12, 15).to_i], # => partial cover, add another 900
      [Time.utc(2021, 2, 1, 15, 15).to_i, Time.utc(2021, 2, 1, 16, 15).to_i], # => no overlap, add another 3601
    ]
  end

  def basic_overlapping_time_values_expected_result
    3601 + 900 + 3601
  end

  def naive_calculation(data)
    data.sort_by { |pair| pair.first }.each_with_object(
      { duration: 0, last_end: 0 }
    ) do |pair, memo|
      if pair.first > memo[:last_end]
        memo[:duration] += pair.last - pair.first + 1
        memo[:last_end] = pair.last
      elsif pair.last > memo[:last_end]
        memo[:duration] += pair.last - memo[:last_end]
        memo[:last_end] = pair.last
      end
    end[:duration]
  end

  def range_operators_calculation(data)
    data.map do |pair|
      Range.new *pair
    end.rangify.collect(&:size).sum
  end

  def test_range_operators_calculation_with_basic_overlapping_integers
    assert_equal(
      basic_overlapping_integers_expected_result,
      range_operators_calculation(basic_overlapping_integers)
    )
  end

  def test_range_operators_calculation_with_basic_overlapping_time_values
    assert_equal(
      basic_overlapping_time_values_expected_result,
      range_operators_calculation(basic_overlapping_time_values)
    )
  end

  def test_naive_calculation_with_basic_overlapping_integers
    assert_equal(
      basic_overlapping_integers_expected_result,
      naive_calculation(basic_overlapping_integers)
    )
  end

  def test_naive_calculation_with_basic_overlapping_time_values
    assert_equal(
      basic_overlapping_time_values_expected_result,
      naive_calculation(basic_overlapping_time_values)
    )
  end
end
