#! /usr/bin/env ruby
require 'minitest/autorun'

class TestNumberedParameters < Minitest::Test
  def test_version
    assert_equal '2.7.0', RUBY_VERSION
  end

  def test_address_single_parameter
    result = [10, 20, 30].map { _1 + 2 }
    assert_equal [12, 22, 32], result
  end

  def get_3x3_matrix
    [
      [1, 10, 100],
      [2, 20, 200],
      [3, 30, 300]
    ]
  end

  def test_address_each_of_mulitple_parameters
    result = get_3x3_matrix.map { _1 + _2 + _3 }
    assert_equal [111, 222, 333], result
  end

  def test_address_mulitple_parameters_together
    result = get_3x3_matrix.map { _1.join(',') }
    assert_equal ["1,10,100", "2,20,200", "3,30,300"], result
  end
end
