#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "best_compressor"

module BestCompressor
  describe TextCompressor do
    it "should be able to add some text" do
      c = TextCompressor.new(text: "")
      c.add_text("first second")
      expect(c.unique).to eq(%w[first second])
      expect(c.index).to eq([0, 1])
    end

    it "should be able to add a word" do
      c = TextCompressor.new(text: "")
      c.add_word("first")
      expect(c.unique).to eq(["first"])
      expect(c.index).to eq([0])
    end

    it "should be able to find the index of a word" do
      c = TextCompressor.new(text: "hello world")
      expect(c.unique_index_of("hello")).to eq(0)
      expect(c.unique_index_of("world")).to eq(1)
    end
    # ...
  end
end
