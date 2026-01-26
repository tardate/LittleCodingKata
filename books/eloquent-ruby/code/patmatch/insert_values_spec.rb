#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

def published_in?(year, info)
  # What do we write here?
end


module Nope
  # Note we are back to arrays here, but this is still a very broken method!

  def published_in?(year, info)
    info in [String, String, :drama | :comedy | :tragedy, year]     # Nope!
  end
end


module Works
  # The working version. Note the ^year.

  def published_in?(year, info)
      info in [String, String, :drama | :comedy | :tragedy, ^year]
  end
end

describe "Misguided attempt to insert a value" do
  include Nope

  it "does not work" do
    info = ["Emma", "Austen", :drama, 1816]

    expect(published_in?(2025, info)).to be_truthy
    expect(published_in?(1, info)).to be_truthy
    expect(published_in?(1816, info)).to be_truthy
  end
end


describe "Inserting values into patterns" do
  include Works
  it "means that array based published_in? function works" do
    info = ["Emma", "Austen", :drama, 1816]

    expect(published_in?(2025, info)).to be_falsey
    expect(published_in?(1, info)).to be_falsey
    expect(published_in?(1816, info)).to be_truthy
  end

  it "works the same way with hashes" do
    expect do
      h_info = {title: "Emma", author: "Austen", genre: :drama, published: 1816}

      the_title = "Emma"
      the_year = 1816

      puts "Match!" if h_info in {title: ^the_title,  published: ^the_year}
    end.to output(/Match/).to_stdout

    t = 4
    expect((
      {title: 1, published: 1} in {title: ^t}
    )).to be_falsey
  end

  it "lets you use any expression" do
      h_info = {title: "Emma", author: "Austen", genre: :drama, published: 1816}
      expect do
        puts "Match!" if h_info in {published: ^(1800 + 16)}
      end.to output(/Match/).to_stdout
  end
end
