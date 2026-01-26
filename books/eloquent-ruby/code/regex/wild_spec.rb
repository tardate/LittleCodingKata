#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "the =~ operator" do
  it "returns nil or an integer" do
    matched = false
    the_string = "At the tone the time will be 08:17 PM. Thank you."
    if /\d\d:\d\d (AM|PM)/ =~ the_string
      # Our string contains a time.
      matched = true
    end

    expect(matched).to be_truthy

    expect(/foo/ =~ the_string).to be_nil
  end

  it "tells you where the match occurred" do
    expect(
    /once/i =~ "Never, never never!"   # nil - no match
    ).to be_nil

    expect(
    /once/i =~ "Once upon a time"      # 0 - right at the beginning
    ).to eq(0)

    expect(
    /once/i =~ "It happened once"      # 12 - towards the end
    ).to eq(12)
  end
end

describe "the !~ operator" do
  it "returns true or false" do
    expect(/abc/ !~ "xxx").to be true
    expect(/abc/ !~ "abc").to be false
  end
end
