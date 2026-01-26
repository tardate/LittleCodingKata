#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module Constant
  ENCRYPTION_ENABLED = true
  require_relative "doc_with_encrypt"

  describe Document do
    it "has encryption enabled" do
      doc = Document.new(author: "russ", title: "title", content: "hello world")
      expect(doc.author).to eq("russ")
      expect(doc.encrypt("abc")).to eq("mno")
    end
  end
end

