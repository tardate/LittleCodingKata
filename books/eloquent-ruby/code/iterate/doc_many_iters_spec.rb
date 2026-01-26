#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_many_iters"

module DocEachChar
  describe "Document with each character." do
    it "should iterate thru each char" do
      expect do
        document = Document.new( title: "test", author: "test", content: "abcd" )
        document.each_char { |ch| puts ch }
      end.to output(/a\nb\nc\nd\n/m).to_stdout
    end
  end
end

module DocEachEachChar
  describe "Document with each and each_char." do
    it "should have an each_char method" do
      expect do
        document = Document.new( title: "test", author: "test", content: "abcd" )
        document.each_char { |ch| puts ch }
      end.to output(/a\nb\nc\nd\n/m).to_stdout
    end

     it "should have an each method that runs thru words" do
      expect do
        document = Document.new(
          title: "test",
          author: "test",
          content: "aaa bbb ccc" )
        document.each { |word| puts word }
      end.to output(/aaa\nbbb\nccc\n/m).to_stdout
    end
  end
end
