#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe Array do
  it "each yields each element to the block" do
    new_array = []
    old_array = [1, 2, 3]

    result_of_each = old_array.each { |item| new_array << item }

    expect(result_of_each).to eq([1, 2, 3])
    expect(new_array).to eq([1, 2, 3])
  end
end
