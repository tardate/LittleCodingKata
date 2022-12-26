#! /usr/bin/env ruby
require 'minitest/autorun'
require 'nokogiri'
require 'open-uri'

class AtomFeedsTest < Minitest::Test
  def feed(source = 'https://leap.tardate.com/catalog/atom.xml')
    Nokogiri::XML(URI.open(source))
  end

  def xkcd
    feed('https://xkcd.com/atom.xml')
  end

  def test_xkcd_namespaces
    namespaces = xkcd.namespaces
    assert_equal namespaces.keys, %w[xmlns]
  end

  def test_xkcd_entries
    doc = xkcd
    assert_equal 0, doc.xpath('//entry').size
    assert_equal 4, doc.xpath('//xmlns:entry').size
  end

  def test_xkcd_entries_without_namespaces
    doc = xkcd
    doc.remove_namespaces!
    assert_equal 4, doc.xpath('//entry').size
    assert_raises(Nokogiri::XML::XPath::SyntaxError, 'Should have raised Undefined namespace prefix SyntaxError') { doc.xpath('//xmlns:entry') }
  end

  def test_namespaces
    namespaces = feed.namespaces
    assert_equal namespaces.keys, %w[xmlns xmlns:g]
  end

  def test_find_category
    result = feed.xpath(%(//xmlns:category[@term="scale models"]))
    assert_equal 56, result.size
    assert_equal 'category', result.first.name
    result
  end

  def test_find_with_category
    result = feed.xpath(%(//xmlns:entry[xmlns:category[@term="scale models"]]))
    assert_equal 56, result.size
    assert_equal 'entry', result.first.name
    result
  end

  def test_filter_by_updated_year
    result = test_find_with_category.each_with_object([]) do |entry, memo|
      updated = Time.parse entry.at('updated').content
      memo << entry if updated.year == 2022
    end
    assert_equal 38, result.size
    assert_equal 'entry', result.first.name
  end

  def test_find_with_updated_starts_with
    result = feed.xpath(%(//xmlns:entry[starts-with(xmlns:updated, "2022-")]))
    assert_equal 75, result.size
    assert_equal 'entry', result.first.name
  end

  def test_combined_category_and_updated_queries
    result = feed.xpath(%(//xmlns:entry[xmlns:category[@term="scale models"]][starts-with(xmlns:updated, "2022-")]))
    assert_equal 38, result.size
    assert_equal 'entry', result.first.name
  end
end
