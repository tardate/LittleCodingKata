#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe Enumerator do
  it "lets you capture an enumeration in an object" do
    array = %w{Four score and seven}

    enum = array.each

    expect do
      puts enum.next        # Prints Four
      puts enum.next        # Prints score
    end.to output("Four\nscore\n").to_stdout

    expect(
      enum.next            # "and"
    ).to eq("and")

    expect(
      enum.next            # "seven"
    ).to eq("seven")

    expect do
      enum.next            # Boom: StopIteration exception.
    end.to raise_error(StopIteration)

    enum.rewind
    enum.next            # "Four"

    enum.rewind
    expect(enum.next).to eq("Four")

    expect do
      # Print each word, from the enum. Not that this does an
      # implicit rewind on the enumeration, so that we get all of
      # the words, even if we have called .next a few times.

      enum.each { puts it }
    end.to output(/Four.*score.*and.*seven/m).to_stdout

    expect do
      # Print the words with their index.

      enum.each_with_index { |w, i| puts "#{i}. #{w}" }
    end.to output(/0. Four.*1. score.*3. seven/m).to_stdout

    expect(
      # Get only the longer words.

      enum.filter { it.size > 4 }
    ).to eq(%w{score seven})
  end
end
