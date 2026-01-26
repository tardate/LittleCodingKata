#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

require "minitest/autorun"

class TestDocument < Minitest::Test
  def setup
    @text = "Exactly three words"
    @doc = Document.new(title: "test", author: "russ", content: @text)
  end

  def test_content_stays_put
    assert_equal @text, @doc.content
  end

  def test_author_doesnt_wander
    assert_match /^r.*s/, @doc.author
  end

  # And so on...
end
