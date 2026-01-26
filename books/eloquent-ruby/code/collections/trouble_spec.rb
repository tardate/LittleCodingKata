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

describe "collections" do
  let(:words) { %w[the the rain in in Spain] }
  let(:unique_words) { Set.new(%w[the rain in Spain]) }

  it "is a bad idea to modify collections while iterating" do
    array = nil
    expect do
      array = [0, -10, -9, 5, 9]
      array.each_index { |i| array.delete_at(i) if array[i] < 0 }
      pp array
    end.to output(/-9/).to_stdout

    expected = 
      [0, -9, 5, 9]
    expect(array).to eq(expected)
  end

  it "is easy to expand an array" do
    array = []
    array[24601] = "Jean Valjean"
    expect(array.length).to eq(24602)
  end

  it "is possible to use a hash to get unique words" do
    # Add each word to the hash => true. Is there a better way?

    word_is_there = {}
    words.each { |word| word_is_there[word] = true }
    expect(Set.new(word_is_there.keys)).to eq(unique_words)
  end

  it "is possible to use an array to get unique words" do
    # Add each word to unique unless it is already there.
    # There has got to be a better way?

    unique = []
    words.each { |word| unique << word unless unique.include?(word) }
    expect(Set.new(unique)).to eq(unique_words)
  end

  it "is better to just use a set" do
    # A better way.

    word_set = Set.new(words)
    expect(word_set).to eq(unique_words)
  end
end
