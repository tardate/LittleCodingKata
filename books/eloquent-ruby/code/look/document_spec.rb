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
  let(:doc) do
    Document.new(title: "Dracula", author: "Stoker", content: "Left Munich...")
  end

  it "picks up the fields in the constructor" do
    expect(doc.title).to eq("Dracula")
    expect(doc.author).to eq("Stoker")
    expect(doc.content).to eq("Left Munich...")
  end

  it "gives you an array of words with words" do
    expect(doc.words).to eq(["Left", "Munich..."])
  end
end
