#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "home_utility"

describe WordProcessor do
  it "can convert pts to inches" do
    expect(WordProcessor.points_to_inches(72)).to be_within(0.001).of(1.0)
    expect(WordProcessor.points_to_inches(0)).to be_within(0.001).of(0)
  end
  it "can convert inches to points" do
    an_inch_full_of_points = WordProcessor.inches_to_points(1.0)
    expect(an_inch_full_of_points).to be_within(0.001).of(72.0)
    expect(WordProcessor.inches_to_points(0)).to be_within(0.001).of(0)
  end
end
