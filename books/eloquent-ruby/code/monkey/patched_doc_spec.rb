#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "patched_doc"

module BadAvgWordLen
  describe Document do
    it "returns infinity for the avg word len of an empty doc" do
      expect do
        # Note the empty content string.
        
        empty_doc = Document.new(title: "Empty!", author: "Russ", content: "")
        puts empty_doc.average_word_length
      end.to output("NaN\n").to_stdout
    end
  end
end

module SaferAvgWordLen
  describe Document do
    it "returns 0.0 for the avg word len of an empty doc" do
      expect do
        empty_doc = Document.new(title: "Empty!", author: "Russ", content: "")
        puts empty_doc.average_word_length
      end.to output(/0\.0/).to_stdout
    end
  end
end
