#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "class" do
  it "is a kind of module" do
    expect do
      puts String.kind_of?(Module)  # True! All classes are modules.
    end.to output(/true/).to_stdout
  end
end



describe :squish! do
  it "removes the repeated spaces from a string" do
    require "active_support"
    require "active_support/core_ext"

    s = " Ruby          Rocks    "
    s.squish!
    expect(s).to eq("Ruby Rocks")
  end
end

