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

def count_till_tuesday(doc)
  count = 0
  doc.each_word do |word|
    count += 1
    break if word == "Tuesday"
  end
  count
end

module DocWithEachWord
  describe "Break behavior" do
    it "stops the iteration" do
      doc = Document.new(title: "test", author: "russ", content: "Sunday Monday Tuesday Wednesday")
      expect(count_till_tuesday(doc)).to eq(3)
    end
  end
end
