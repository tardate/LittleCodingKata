#! /usr/bin/env ruby
require 'minitest/autorun'
require 'yaml'

def load_example(filename)
  YAML.load_file(File.join('examples', filename))
end

class TestExamples < Minitest::Test
  def test_lists
    result = load_example('1_lists.yaml')
    assert_instance_of Array, result
    assert_equal 3, result.size
    assert result.include? 'Casablanca'
  end

  def test_inline_lists
    result = load_example('2_inline_lists.yaml')
    assert_instance_of Array, result
    assert_equal 4, result.size
    assert result.include? 'eggs'
  end

  def test_maps
    result = load_example('3_maps.yaml')
    assert_instance_of Hash, result
    assert_equal %w[name age address], result.keys
    assert_equal %w[street city], result['address'].keys
  end
end
