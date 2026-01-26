#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "unrelated_docs"

module UnrelatedDocs
  describe Document do
    let(:doc) do
      Document.new(author: "russ", title: "title", content: "Hello world!\n")
    end

    it "remembers its content" do
      expect(doc.content).to eq("Hello world!\n")
    end

    it "has a words method that returns an array of words" do
      expect(doc.words).to eq(%w(Hello world!))
    end

    it "has a word_count method that returns the # of words" do
      expect(doc.word_count).to eq(2)
    end
  end

  describe LazyDocument do
    let(:doc) { LazyDocument.new(path: "hello.txt") }

    it "remembers its content" do
      expect(doc.content).to eq("Hello world!\n")
    end

    it "has a words method that returns an array of words" do
      expect(doc.words).to eq(%w(Hello world!))
    end
  end
end

