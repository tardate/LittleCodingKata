#! /usr/bin/env ruby
require 'minitest/autorun'
require 'nokogiri'
require 'pathname'

class NokogiriXmlTest < Minitest::Test
  def doc
    source_file = Pathname.new(File.dirname(__FILE__)).join('data', 'planes.xml')
    Nokogiri::XML(File.open(source_file))
  end

  def test_xpath_finds_by_name
    result = doc.xpath("//model")
    assert_equal 2, result.size
    assert_equal %w[Skyhawk Cherokee], result.collect(&:content).collect(&:strip)
    assert_equal 'Skyhawk', result.first.content.strip
  end

  def test_xpath_finds_by_attribute_value
    result = doc.xpath(%(//seller[@phone="555-222-3333"]))
    assert_equal 1, result.size
    assert_equal 'Skyway Aircraft', result.first.content.strip
  end

  def test_xpath_finds_by_has_child
    result = doc.xpath(%(//ad[price]))
    assert_equal 1, result.size
    assert_equal 'Skyhawk', result.first.at('model').content.strip
  end
end
