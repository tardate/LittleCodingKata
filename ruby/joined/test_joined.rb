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

  def test_with_words_connector
    result = %w[apples oranges pears].joined(words_connector: ' - ')
    assert_equal 'apples - oranges, and pears', result
  end

  def test_with_last_word_connector
    result = %w[apples oranges pears].joined(last_word_connector: ', - ')
    assert_equal 'apples, oranges, - pears', result
  end

  def test_all_custom_options
    result = %w[apples oranges pears].joined(words_connector: ' - ', last_word_connector: ', - ', oxford: false)
    assert_equal 'apples - oranges - pears', result
  end
end
