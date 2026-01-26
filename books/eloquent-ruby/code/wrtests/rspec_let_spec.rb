#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

RSpec.describe Document do
  let(:text) { "A bunch of words" }
  let(:doc) { Document.new(title: "test", author: "russ", content: text) }

  let(:really_expensive) { sleep(200) }


  it "holds on to the contents" do
    expect(doc.content).to eq(text)
  end

  it "returns all of the words in the document" do
    expect(doc.words).to include("A")
    expect(doc.words).to include("bunch")
    expect(doc.words).to include("of")
    expect(doc.words).to include("words")
  end

  it "knows how many words it contains" do
    expect(doc.word_count).to eq(4)
  end
end
