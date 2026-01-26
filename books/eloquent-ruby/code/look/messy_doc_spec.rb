#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "messy_doc"

module MessyDoc
  RSpec.describe Document do
    let(:doc) { Document.new(title: "t", author: "a", content: "hello world") }

    it "picks up the fields in the constructor" do
      expect(doc.title).to eq("t")
      expect(doc.author).to eq("a")
      expect(doc.content).to eq("hello world")
    end

    it "gives you an array of words with words" do
      expect(doc.words).to eq(["hello", "world"])
    end
  end
end
