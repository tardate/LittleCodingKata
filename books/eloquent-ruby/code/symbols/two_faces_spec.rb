#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "active_support"
require "active_support/core_ext"

describe "ActiveSupport" do
  it "give you handy number conv methods, driven by symbols" do
    expect(
      #  The to_fs method comes to us courtesy of ActiveSupport.

      50.to_fs(:percentage)        # Gives us the string "50.000%"
    ).to eq("50.000%")

    expect(
      5558765309.to_fs(:phone)     # Gives us "555-867-5309"
    ).to eq("555-876-5309")

    expect(
      1391000.to_fs(:human)        # Gives us "1.39 Million"
    ).to eq("1.39 Million")
  end

  it "requires a symbol for an argument" do
    expect do
      #  Don't try this at home!

      50.to_fs("percentage")        # Boom.
      1391000.to_fs("human")        # Earth shattering boom.
    end.to raise_error(TypeError)
  end
end
