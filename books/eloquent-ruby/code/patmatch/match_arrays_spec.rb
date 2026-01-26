#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

def process_book(info)
  # Do something with the book info, if it is indeed book info.
end

def published_in_1816?(info)
  info in [String, String, :drama | :comedy | :tragedy, 1816]
end

module HardWay
  def valid_book?(info)
    return false unless info in Array
    return false unless info.length == 4
    return false unless info[0] in String
    return false unless info[1] in String
    return false unless info[2] in Symbol
    return false unless info[3] in Integer
    true
  end

  def process_book(info)
    if valid_book?(info)
      # Do something with the book info...
    end
  end
end

module BetterWay
  # A better way...

  def valid_book?(info)
    info in [String, String, Symbol, Integer]
  end
end

module Pickier
  # A pickier pattern.

  def valid_book?(info)
    info in [String, String, :drama | :comedy | :tragedy, Integer]
  end
end

RSpec.shared_examples "valid_book?" do  |valid_book_module| 
  include valid_book_module

  let(:info) do
    info = ["Emma", "Austen", :drama, 1816]
    info
  end

  it "matches good book info arrays" do
    expect(valid_book?(info)).to be_truthy
    expect(valid_book?(["Title", "Author", :drama, 0])).to be_truthy
    expect(valid_book?(["Title", "Author", :comedy, 0])).to be_truthy
    expect(valid_book?(["Title", "Author", :tragedy, 0])).to be_truthy
  end

  it "does not match bad info objects" do
    expect(valid_book?(44)).to be_falsey
    expect(valid_book?([])).to be_falsey
    expect(valid_book?([1, 2, 3, 4])).to be_falsey
    expect(valid_book?(["Title", "Author", :sym])).to be_falsey
    expect(valid_book?(["Title", "Author"])).to be_falsey
    expect(valid_book?(["Title", "Author", :sym, 0, 44])).to be_falsey
  end
end

describe HardWay do
  include_examples "valid_book?", HardWay
end

describe BetterWay do
  include_examples "valid_book?", BetterWay
end

describe Pickier do
  include_examples "valid_book?", Pickier

  it "only matches standard genres" do
    expect(valid_book?(["Title", "Author", :xxx, 0])).to be_falsey
  end
end

describe "published_in_1816" do
  it "only matches books published in 1816" do
    expect(published_in_1816?(["Title", "Author", :drama, 1816])).to be_truthy
    expect(published_in_1816?(["Title", "Author", :drama, 1817])).to be_falsey
    expect(published_in_1816?([1817])).to be_falsey
  end
end

describe "array wildcards" do
  it "soaks up elements in the array" do
    info = ["Emma", "Austen", :drama, 1816]
 
    expect((
      info in [String, *]
    )).to be_truthy

    expect((
      info in [String, *, Integer]
    )).to be_truthy

    expect((
      info in [*, Symbol, *]
    )).to be_truthy
  end
end
