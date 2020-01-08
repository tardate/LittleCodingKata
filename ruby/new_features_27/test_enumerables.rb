#! /usr/bin/env ruby
require 'minitest/autorun'

class TestEnumerables < Minitest::Test
  def test_version
    assert_equal '2.7.0', RUBY_VERSION
  end

  def test_filter_map
    result = (1..5).filter_map { |i| i**2 if i.even? }
    assert_equal [4, 16], result
  end

  def test_tally
    result = %w[Ruby Python Ruby Perl Python Ruby].tally
    expected = {'Ruby' => 3, 'Python' => 2, 'Perl' => 1}
    assert_equal expected, result
  end
end
