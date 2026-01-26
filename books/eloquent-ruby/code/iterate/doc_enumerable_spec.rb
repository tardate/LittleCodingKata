#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_enumerable"

module EnumerableDoc
  describe "Enumerable Documents" do
    it "pulls in all of the enumerable methods" do
      doc = Document.new(
        title: "Advice",
        author: "Harry",
        content: "Go ahead make my day")
      
      expect(doc.include?("make")).to be_truthy
      expect(doc.include?("Punk")).to be_falsey

      expect(doc.find {|x| x=="make"}).to eq("make")
      expect(doc.find {|x| x=="qqq"}).to be_nil

      sorted = doc.sort
      expect(sorted.first).to eq("Go")
      expect(sorted.last).to eq("my")

      cons = doc.each_cons(2).to_a
      expect(cons).to eq([%w[Go ahead], %w[ahead make], %w[make my], %w[my day]])

      a = doc.to_a
      expect(doc.to_a).to eq(%w[Go ahead make my day])
    end
  end
end
