#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document_variations"
require_relative "romance_novel"

describe Document do
  it "has a constructor and a word_count method" do
    doc = Document.new(
      title: "Ethics",
      author: "Spinoza",
      content: "By that which is..."
    )

    wc =
    doc.word_count
    expect(wc).to eq(4)
  end

  it "has an about_me method" do
    doc = Document.new(
      title: "Ethics",
      author: "Spinoza",
      content: "By that which is..."
    )

    expected = <<~EOF
      I am #<Document:0x8766ed4>
      My title is Ethics
      I have 4 words
    EOF
    expect{ doc.about_me }.to output(/I am.*Ethics.*4 words*/m).to_stdout
  end
end

describe RomanceNovel do
  it "is a subclass of Document" do
    expect(RomanceNovel.superclass).to eq(Document)
  end
end
