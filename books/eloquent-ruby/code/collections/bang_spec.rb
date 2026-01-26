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

describe "the reverse method" do
  it "does not affect the original" do
    numbers = [1, 2, 3]
    numbers.reverse
    expect(numbers).to eq([1,2,3])
  end

  it "makes a copy" do
    numbers = [1, 2, 3]
    result =
      [3, 2, 1]
    new_numbers = numbers.reverse
    expect(new_numbers).to eq(result)
  end

  it "has a bang version that modifies the array" do
    numbers = []
    expect do
      numbers = [1, 2, 3]
      numbers.reverse!
      pp numbers
    end.to output(/3.*2.*1/m).to_stdout
    result =
      [3, 2, 1]
    expect(numbers).to eq(result)
  end
end
