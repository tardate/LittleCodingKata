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

class Book < Document; end

describe Symbol do
  it "is interned" do
    a = :percentage
    b = a
    c = :percentage
    expect(b).to be(a)
    expect(c).to be(a)
    expect(b).to be(c)

    expect(
      # True! All true!
      a == c
    ).to be_truthy

    expect(
      a === c
    ).to be_truthy

    expect(
      a.eql?(c)
    ).to be_truthy

    expect(
      a.equal?(c)
    ).to be_truthy
  end

  it "creates a new string with literals" do
    # By default, x and y will be different objects.
    
    x = "percentage"
    y = "percentage"
    expect(x).not_to be(y)
  end

  it "is better than a string for hash keys" do
    author = "jules verne"
    title = "from earth to the moon"
    hash = { author => title }
    expect(hash[author]).to eq(title)

    author_copy = author.clone
    author.upcase!
    expect(hash[author_copy]).to eq(title)
    expect(hash.has_key?(author)).to be_falsy
  end
end
