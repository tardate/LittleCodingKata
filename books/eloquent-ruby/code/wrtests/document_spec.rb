#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

require "rspec"
require_relative "document"

describe Document do
  it "holds onto its title and author" do
    text = "Exactly three words"
    doc = Document.new(title: "test", author: "russ", content: text)
    expect(doc.title).to eq("test")
    expect(doc.author).to eq("russ")
  end

  it "holds on to the contents" do
    text = "Exactly three words"
    doc = Document.new(title: "test", author: "russ", content: text)

    expect(doc.content).to eq(text)
  end

  it "returns all of the words in the document" do
    text = "Exactly three words"
    doc = Document.new(title: "test", author: "russ", content: text)

    expect(doc.words).to match_array(%w[Exactly three words])
  end

  it "knows how many words it contains" do
    text = "Exactly three words"
    doc = Document.new(title: "test", author: "russ", content: text)

    expect(doc.word_count).to eq(3)
  end
end
