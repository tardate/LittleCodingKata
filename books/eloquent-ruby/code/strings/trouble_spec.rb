#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "a Ruby string" do
  it "lets you alias strings" do
    first_name = "Karen"
    given_name = first_name

    first_name[0] = "D"
    expect(first_name).to be(given_name)
    expect(given_name[0]).to eq("D")
  end

  it "is better to make modified copies" do
    first_name = original = "brandon"
    uppercase_first_name = first_name.upcase
    expect(uppercase_first_name).to eq("BRANDON")
    expect(original).to eq("brandon")
  end

  it "can change out from under you" do
    first_name = original = "brandon"
    first_name.upcase!
    expect(original).to eq("BRANDON")
    expect(original).to be(original)
  end

  it "lets you freeze strings" do
    expect do
    first_name = "Karen"
    first_name.freeze

    first_name[0] = "D"          # Boom
    end.to raise_error(FrozenError)
  end

  it "lets you use -1 for the last char" do
    first_name = "brandon"
    expect(
      first_name[first_name.size - 1]
    ).to eq("n")

    expect(
      first_name[-1]
    ).to eq("n")
  end
end
