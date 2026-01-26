#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# frozen_string_literal: true

require "rspec"

describe "the magic frozen string at the top of the file" do
  it "freezes string literals by default" do
    # frozen_string_literal: true
    frosty = "The Snowman!"
    frosty.frozen?                        # True!
    expect(frosty.frozen?).to be_truthy
  end

  it "doesn't freeze other strings" do
    # frozen_string_literal: true

    desc = "The Snowman!"                 # Frozen!
    first_char = desc[0]                  # Not Frozen!
    some_digits = 123.to_s                # Not frozen!
    interpolated = "Frosty #{desc} "      # Not frozen!
    expect(desc.frozen?).to be_truthy
    expect(first_char.frozen?).to be_falsey
    expect(some_digits.frozen?).to be_falsey
    expect(interpolated.frozen?).to be_falsey
  end
end
