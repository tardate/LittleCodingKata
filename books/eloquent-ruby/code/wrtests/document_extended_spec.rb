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
  let(:text) { "Exactly three words" }
  let(:doc) { Document.new(title: "test", author: "russ", content: text) }

  it "has more than two words" do
    expect(doc.word_count).to be > 2
  end

  it "has less than a million words" do
    expect(doc.word_count).to be < 1_000_000
  end

  it "has a word we expect" do
    expect(doc.words).to include("three")
  end

  it "has the text we expect" do
    expect(doc.content).to match(/three wo/)
  end

  it "outputs the correct message" do
    expect do
      puts "The text is #{doc.content}"
    end.to output(/The text is Exactly/).to_stdout
  end

  it "doesnt have a particular word" do
    expect(doc.words).to_not include("Excelsior")
  end
end
