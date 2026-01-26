#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_operators"

describe "ruby operators" do
  it "are mostly a method calls" do
    first = 10
    second = 20

    sum = first + second

    expect(sum).to eq(30)

    sum = -999

    sum = first.+(second)

    expect(sum).to eq(30)
  end

  it "deals with operator precedence" do
    first = 10
    second = 20
    third = 3
    fourth = 1

    result = first + second * (third - fourth)

    expect(result).to eq(50)

    result = -999

    result = first.+(second.*(third.-fourth))

    expect(result).to eq(50)
  end

  it "uses << to append to arrays" do
    names = []
    names << "Rob"      # names.size is now 1
    names << "Denise"   # names.size is now 2
    expect(names).to eq(%w[Rob Denise])
  end
end
