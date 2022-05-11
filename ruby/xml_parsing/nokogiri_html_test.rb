#! /usr/bin/env ruby
require 'minitest/autorun'
require 'nokogiri'
require 'open-uri'

class NokogiriHtmlTest < Minitest::Test
  EXPECTED_H2_TITLES = [
    "Meta¶",
    "Installing Native Gems¶",
    "Installing the ruby platform gem¶",
    "Troubleshooting¶",
    "Appendix A: The Compiler Toolchain¶"
  ].freeze

  def doc
    source = 'https://nokogiri.org/tutorials/installing_nokogiri.html'
    Nokogiri::HTML(URI.open(source))
  end

  def test_css_finds_nodes
    result = doc.css('nav ul.menu li a', 'article h2')
    assert_equal 5, result.size
    assert_equal EXPECTED_H2_TITLES, result.collect(&:content)
  end

  def test_xpath_finds_nodes
    result = doc.xpath('//nav//ul//li/a', '//article//h2')
    assert_equal 92, result.size
    assert_equal 'Overview', result.first.content.strip
  end

  def test_search_finds_nodes
    result = doc.search('nav ul.menu li a', '//article//h2')
    assert_equal 5, result.size
    assert_equal EXPECTED_H2_TITLES, result.collect(&:content)
  end
end
