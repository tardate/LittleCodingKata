#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

require_relative "font"
require_relative "paper_size"

module LittleAtATime
  describe "stripped down Rendering" do
    it "has a default font" do
      expect(Rendering::DEFAULT_FONT.class).to eq(Rendering::Font)
    end

    it "has a default paper size" do
      expect(Rendering::DEFAULT_PAPER_SIZE.class).to eq(Rendering::PaperSize)
    end
  end
end
