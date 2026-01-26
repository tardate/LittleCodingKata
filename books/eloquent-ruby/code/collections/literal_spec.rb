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

describe "array literal" do
  it "starts with the most familiar" do
    poem_words = ["twinkle", "little", "star", "how", "I", "wonder"]
    expect(poem_words.length).to eq(6)
    expect(poem_words[0]).to be_a(String)
  end

  it "includes a simply way to do words" do
    poem_words = %w{twinkle little star how I wonder}
    expect(poem_words.length).to eq(6)
    expect(poem_words[0]).to be_a(String)
  end

  it "includes a simply way to do symbols" do
    # An array of symbols: [:red, :green, :blue]

    color_symbols = %i{red green blue}
    expect(color_symbols.length).to eq(3)
    expect(color_symbols[0]).to be_a(Symbol)
  end
end

describe "hash literal" do
  it "has a the original syntax which works with anything" do
    freq = {"I" => 1, "don't" => 1, "like" => 1, "spam" => 963}
    expect(freq["spam"]).to eq(963)
  end

  it "lets you use the original syntax with symbols" do
    author_info = {:first_name => "Brandon", :last_name => "Weaver"}
    expect(author_info[:first_name]).to eq("Brandon")
  end

  it "has a shortcut for symbols" do
    author_info = {first_name: "Brandon", last_name: "Weaver"}
    expect(author_info[:first_name]).to eq("Brandon")
  end

    it "has a shortcut for local variables" do
    first_name = "Brandon"
    last_name = "Weaver"

    # Do stuff with first_name and last_name...

    # Finally, make a hash using the values of the local variables.
    author_info = {first_name:, last_name:}
    expect(author_info[:first_name]).to eq("Brandon")
  end
end
