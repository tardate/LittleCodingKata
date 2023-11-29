#! /usr/bin/env ruby
require 'minitest/autorun'
require 'active_support'
require 'active_support/core_ext'

class TestWithDefaults < Minitest::Test
  def setup
    @params = { a: 'value of a', b: 'value of b' }
    @defaults = { a: 'default value of a', b: 'default value of b', c: 'default value of c' }
  end

  def test_with_defaults
    result = @params.with_defaults(@defaults)
    expected = { a: 'value of a', b: 'value of b', c: 'default value of c' }
    assert_equal expected, result
  end
end
