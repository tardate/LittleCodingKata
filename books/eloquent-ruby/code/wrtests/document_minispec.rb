#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "minitest/autorun"
require_relative "document"

describe Document do
  let(:text) { "Exactly three words" }
  let(:doc) do
    Document.new(title: "test", author: "russ", content: text)
  end

  describe ".content" do
    it "keeps the content" do
      expect(doc.content).must_equal text
    end
  end

  describe ".words" do
    it "returns a array" do
      expect(doc.words).must_be_instance_of Array
    end

    it "returns all of the words in an array" do
      expect(doc.words).must_include "Exactly"
      expect(doc.words).must_include "three"
      expect(doc.words).must_include "words"
    end
  end
end

describe Document do
  let(:text) { "Exactly three words" }
  let(:doc) do
    Document.new(title: "test", author: "russ", content: text)
  end

  describe ".words" do
    it "returns a array" do
      _(doc.words).must_be_instance_of Array
    end

    it "returns all of the words in an array" do
      _(doc.words).must_include "Exactly"
      _(doc.words).must_include "three"
      _(doc.words).must_include "words"
    end
  end
end
