#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "simple if expression" do
  it "works like an if expression" do
    numerator = 10
    [10, 5, 0, 1].each do |divisor|
      quotient = nil
      if divisor != 0
        quotient = numerator / divisor
      end
      if divisor == 0
        expect(quotient).to be_nil
      else
        expect(quotient).to eq(numerator/divisor)
      end
    end
  end
end
