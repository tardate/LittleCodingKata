#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_each_word"

module DocWithEachWord
  describe "each_word" do
    it "runs thru each word in the document" do
      expect do
        document = Document.new(
          title: "Truth",
          author: "Gump",
          content: "Life is like a box of ..." )

        document.each_word { |word| puts word }
      end.to output(/Life\nis\nlike\n/m).to_stdout
    end

    it "should just stop if there is an exception in the block" do
      expect do
        document = Document.new(
          title: "Truth",
          author: "Gump",
          content: "Life is like a box of ..." )

        document.each_word do |word|
          raise 'boom' if word == 'like'
        end
      end.to raise_error(Exception)
    end
  end
end
