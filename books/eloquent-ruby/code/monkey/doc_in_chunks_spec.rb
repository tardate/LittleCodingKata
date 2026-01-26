#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_in_chunks"

RSpec.describe Document do
  it "holds on to the contents" do
    text = "Exactly three words"
    doc = Document.new(title: "test", author: "nobody", content: text)

    expect(doc.content).to eq(text)
    expect(doc.words).to eq(%w[Exactly three words])
    expect(doc.word_count).to eq(3)
  end
end
