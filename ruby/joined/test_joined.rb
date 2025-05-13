#! /usr/bin/env ruby
require 'minitest/autorun'
require 'joined'

class JoinedTest < Minitest::Test
  def test_simple_word_array
    result = %w[apples oranges pears].joined
    assert_equal 'apples, oranges, and pears', result
  end

  def test_without_oxford_comma
    result = %w[apples oranges pears].joined(oxford: false)
    assert_equal 'apples, oranges and pears', result
  end
end
