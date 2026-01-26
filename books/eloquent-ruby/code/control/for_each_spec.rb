#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "for_each"

OUTPUT_RE=/cour.*times.*tica\n/m

describe "for_fonts method" do
  it "outputs what we expect" do
    expect{ for_fonts }.to output(OUTPUT_RE).to_stdout
  end
end

describe "fonts_each method" do
  it "outputs what we expect" do
    expect{ fonts_each }.to output(OUTPUT_RE).to_stdout
  end
end
