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

describe Hash do
  it "retains the order in which it was created" do
    hey_its_ordered = {first: "mama", second: "papa", third: "baby"}

    expect do
      hey_its_ordered.each { |entry| pp entry }
    end.to output(/mama.*papa.*baby/m).to_stdout
  end

  it "adds new entries to the end" do
    hey_its_ordered = {first: "mama", second: "papa", third: "baby"}
    hey_its_ordered[:fourth] = "grandma"
    expected = 
    {first: "mama", second: "papa", third: "baby", fourth: "grandma"}
    expect(hey_its_ordered).to eq(expected)
  end
end
