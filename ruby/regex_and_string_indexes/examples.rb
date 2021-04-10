#! /usr/bin/env ruby
require 'minitest/autorun'

class TestLoops < Minitest::Test
  TEXT = 'Plant a memory, plant a tree, do it today for tomorrow.'.freeze

  def test_plain_text_search_regex
    assert TEXT =~ /memory/
  end

  def test_plain_text_search_substring
    assert TEXT['memory']
  end

  def test_content_of_match
    assert_equal 'plant a tree', TEXT[/pl.*ee/]
  end

  def test_replace_capture_group
    text = TEXT.dup
    text[/it\s(\w+)/, 1] = 'now'
    assert_equal 'Plant a memory, plant a tree, do it now for tomorrow.', text
  end
end
