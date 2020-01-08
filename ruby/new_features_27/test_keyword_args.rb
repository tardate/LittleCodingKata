#! /usr/bin/env ruby
require 'minitest/autorun'

class TestKeywordArgs < Minitest::Test
  def test_version
    assert_equal '2.7.0', RUBY_VERSION
  end

  def receiver(*args)
    args
  end
  def delegator(...)
    receiver(...)
  end

  def test_delegation
    assert_equal %w[a], delegator('a')
    assert_equal ['a', [1, 2]], delegator('a', [1, 2])
    assert_equal [], delegator
    assert_equal [], delegator(*nil)
    assert_equal [nil], delegator(nil)
  end
end
