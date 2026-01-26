#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "political_writing_quality"

module ModulePrecedence
  describe PoliticalBook do
    it "has no rules" do
      content = "my way or the highway"
      doc = PoliticalBook.new(title: "screed", author: "russ", content:)
      expect(doc.number_of_cliches).to eq(0)
    end
  end
end
