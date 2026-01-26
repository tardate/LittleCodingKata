#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document"

RSpec.describe Document do
  let(:text) { "Exactly three words" }
  let(:doc) { Document.new(title: "test", author: "russ", content: text) }

  it "holds on to the contents" do
    # Note that doc and text are defined here.

    expect(doc.content).to eq(text)
  end

  it "returns all of the words in the document" do
    # Note that doc is defined here. We could also
    # use text here, but we don't need it.

    expect(doc.words.include?("Exactly")).to be_truthy
    expect(doc.words.include?("three")).to be_truthy
    expect(doc.words.include?("words")).to be_truthy
  end

  # And so on...
end
