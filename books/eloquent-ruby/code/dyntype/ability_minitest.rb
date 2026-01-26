#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "minitest/autorun"
require_relative "related_docs"
require_relative "unrelated_docs"

Factories = [
  -> () do
    RelatedDocs::Document.new(
      author: "russ", 
      title: "test", 
      content: "Hello world!\n") 
  end,

  -> () { RelatedDocs::LazyDocument.new(path: "hello.txt") },

  -> () do
    UnrelatedDocs::Document.new(
      author: "russ", 
      title: "test", 
      content: "Hello world!\n") 
  end,

  -> () { UnrelatedDocs::LazyDocument.new(path: "hello.txt") },
]


def get_some_kind_of_document
  @kind_index ||= 0
  doc = Factories[@kind_index].call
  @kind_index = (@kind_index + 1) % Factories.size
  doc
end

class TestRelatedUnrelatedDocuments < Minitest::Test
  def test_content
    Factories.each do |f|
      assert_equal(f.call.content, "Hello world!\n")
    end
  end

  def test_words
    Factories.each do |f|
      assert_equal(f.call.words, %w(Hello world!))
    end
  end

  def test_title
    Factories.each do |f|
      assert_equal(f.call.title, "test")
    end
  end

  def test_author
    Factories.each do |f|
      assert_equal(f.call.author, "russ")
    end
  end

  def test_polymorphic
    Factories.size.times do |i|
      doc = get_some_kind_of_document
      assert_output(/Title: test.*russ.*Hello/m) do
        puts "Title: #{doc.title}"
        puts "Author: #{doc.author}"
        puts "Content: #{doc.content}"
      end
    end
  end
end
