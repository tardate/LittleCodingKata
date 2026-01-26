#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

def good_genre?(genre)
  genre in String | :comedy | :drama | :tragedy
end

def print_genre(genre)
  if genre in String | :comedy | :drama | :tragedy
    puts "The genre is #{genre}"
  end
end

def describe_genre(genre)
  case genre
  in :comedy | :drama | :tragedy
    puts "The genre is #{genre}"
  in String
    puts "You need to read the chapter on symbols!"
  in Integer | Float
    puts "A numeric genre makes no sense!"
  else
    puts "Are you sure you understand this genre thing?"
  end
end

describe "Regular expressions" do
  it "matches the strings you want" do

    # This regular expression string that looks like a (US) time, 
    # perhaps "09:24 AM".

    TIME_RE = /\d\d:\d\d (AM|PM)/

    def is_time?(s) = TIME_RE.match?(s)

    expect(is_time?("09:24 AM")).to be_truthy
    expect(is_time?("09:00 AM")).to be_truthy
    expect(is_time?("09:24 PM")).to be_truthy
    expect(is_time?("12:36 PM")).to be_truthy

    expect(is_time?("foo")).to be_falsey
  end
end

describe "Pattern matching" do
  before(:each) do
 end

  # One of the odd things about pattern matching is that `a in b`
  # apparently needs to be surrounded by parens in a method call.
  
  it "matches simple literals and classes" do
    title = "Emma"
    genre = :drama
    published = 1816

    title in "Emma"               # True! The two strings are equal.
    title in "Persuasion"         # False! The strings are not equal.
    genre in :drama               # True! It's the same symbol.
    published in 1816             # True again!
    published in 1066             # Nope!
    #
     
    results = [
    (title in "Emma"),
    (title in "Persuasion"),
    (genre in :drama),
    (published in 1816),
    (published in 1066)]

    expect(results).to eq([true, false, true, true, false])

    title in String             # True
    title in Integer            # Nope, the title is not an integer.
    published in Integer        # True: 1816 is an integer.
    published in Numeric        # True: Integer is a subclass of Numeric.

    results = [
    (title in String),
    (title in Integer),
    (published in Integer),
    (published in Numeric)]

    expect(results).to eq([true, false, true, true])

    published in Integer | String         # true! It's an integer.
    title in Integer | String             # true again! This time a string.
    genre in Integer | String             # Nope, genre is a symbol!
    genre in :comedy | :drama | :tragedy    # Yes, it is the second one!

    results = [
    (published in Integer | String),
    (title in Integer | String),
    (genre in Integer | String),
    (genre in :comedy | :drama | :tragedy)]

    expect(results).to eq([true, true, false, true])
  end
end

describe :good_genre?  do
  it "allows strings and specific symbols" do
    expect(good_genre?("Drama")).to be_truthy
    expect(good_genre?("Literally anything")).to be_truthy
    expect(good_genre?(:comedy)).to be_truthy
    expect(good_genre?(:drama)).to be_truthy
    expect(good_genre?(:tragedy)).to be_truthy

    expect(good_genre?(:music_video)).to be_falsey
    expect(good_genre?(44)).to be_falsey
    expect(good_genre?(false)).to be_falsey
  end
end

describe :print_genre do
  it "prints what we expect" do
    expect { print_genre(:comedy) }.to output(/The genre /).to_stdout
    expect { print_genre(:drama) }.to output(/The genre /).to_stdout
    expect { print_genre(:tragedy) }.to output(/The genre /).to_stdout
    expect { print_genre(:foo) }.to output("").to_stdout
    expect { print_genre(42) }.to output("").to_stdout
  end
end

