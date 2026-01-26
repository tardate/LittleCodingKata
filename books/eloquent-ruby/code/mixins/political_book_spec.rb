#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "political_book"

module Political
  describe Document do
    it "does normal cliche checking" do
      content = "my way or the highway"
      doc = Document.new(title: "title", author: "author", content:)
      expect(doc.number_of_cliches).to eq(1)
    end
  end

  describe PoliticalBook do
    it "does normal cliche checking" do
      content = "my way or the highway"
      doc = PoliticalBook.new(title: "title", author: "author", content:)
      expect(doc.number_of_cliches).to eq(0)
    end
  end
end
