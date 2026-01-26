#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module BasicDocumentTest
  require "minitest/autorun"
  require_relative "document"

  class DocumentTest < Minitest::Test
    def test_that_doc_knows_its_title_and_author
      text = "Exactly three words"
      doc = Document.new(title: "test", author: "russ", content: text)
      assert_equal(doc.title, "test")
      assert_equal(doc.author, "russ")
    end

    def test_document_holds_onto_contents
      text = "Exactly three words"
      doc = Document.new(title: "test", author: "russ", content: text)
      assert_equal text, doc.content
    end

    def test_that_doc_can_return_words_in_array
      text = "Exactly three words"
      doc = Document.new(title: "test", author: "russ", content: text)
      assert_equal(doc.words, %w[Exactly three words])
    end

    def test_that_word_count_is_correct
      text = "Exactly three words"
      doc = Document.new(title: "test", author: "russ", content: text)
      assert_equal 3, doc.word_count, "Word count is correct"
    end

    def test_other_things
      text = "Exactly three words"
      doc = Document.new(title: "test", author: "russ", content: text)
      assert doc.instance_of?(Document)
      assert_instance_of Document, doc
      assert_empty []
      assert_empty ""
      assert doc.words.size == 3
      refute_instance_of Integer, doc
      refute_empty "Not empty!"
      refute doc.words.size > 555
    end
  end
end
