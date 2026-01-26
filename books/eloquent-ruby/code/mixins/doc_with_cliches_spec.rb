#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_cliches"

describe Document do
  let(:doc0) do
    Document.new(
      title: "test2", 
      author: "russ",
      content: "there are no cliches here"
    )
  end

  let(:doc1) do
    Document.new(
      title: "test1", 
      author: "russ",
      content: "look, it's my way or the highway"
    )
  end

  let(:doc2) do
    Document.new(
      title: "test1", 
      author: "russ",
      content: "make no mistake he plays fast and loose",
    )
  end

  it "can count cliches in the content" do
    expect(doc0.number_of_cliches).to eq(0)
    expect(doc1.number_of_cliches).to eq(1)
    expect(doc2.number_of_cliches).to eq(2)
  end
end
