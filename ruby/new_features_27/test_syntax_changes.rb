#! /usr/bin/env ruby
require 'minitest/autorun'

class TestSyntaxChanges < Minitest::Test
  def test_version
    assert_equal '2.7.0', RUBY_VERSION
  end

  def test_comments
    result = (1..9).select(&:odd?)
      # This comment was not possible in 2.6
      .map { |x| x**2 }
    assert_equal [1, 9, 25, 49, 81], result
  end

  def test_rescue_with_multiple_assignment
    a, b = raise rescue [1, 2]
    assert_equal 1, a
    assert_equal 2, b
  end

  def test_beginless_range
    assert_equal %w[a b], %w[a b c][..1]

    generation = ->(year) do
      case year
      when ...1945 then 'Silent'
      when 1946...1964 then 'Boomer'
      when 1965...1980 then 'GenX'
      when 1981...1996 then 'Millennial'
      when 1997... then 'GenZ'
      end
    end

    assert_equal 'Silent', generation.call(1937)
    assert_equal 'Boomer', generation.call(1951)
    assert_equal 'GenX', generation.call(1967)
    assert_equal 'Millennial', generation.call(1993)
    assert_equal 'GenZ', generation.call(2010)
  end
end
