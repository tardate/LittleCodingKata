#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_bad_keywords"


module BadKeywordArgs
  describe "make a doc" do
    it "returns a Document instance" do
      expect(
        Document.new(t: "Dracula", a: "Stoker", c: "Left Munich...")
      ).to be_kind_of(Document)
    end
  end
end
