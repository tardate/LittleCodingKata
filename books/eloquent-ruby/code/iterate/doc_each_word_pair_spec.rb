#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_each_word_pair"


module DocEachWordPair
  describe "Document with each word pair." do
    it "should iterate thru each word pair" do
      expect do
        document = Document.new(
          title: "Donuts",
          author: "Homer",
          content: "I love donuts mmm donuts" )

        document.each_word_pair { |word1, word2| puts "#{word1} #{word2}" }
      end.to output(/I love\nlove donuts\ndonuts mmm\nmmm donuts/m).to_stdout
    end
  end
end
