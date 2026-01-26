#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "rendering"

class BookPrinter
  include Rendering

  # ...
  
  def display_printing_defaults
    puts "The default font is #{DEFAULT_FONT.name}"
    puts "The default paper height is #{DEFAULT_PAPER_SIZE.height}"
  end
end

describe Rendering do
  it "has a Font class" do
    f = Rendering::Font.new(name: "times new russ", weight: :bold, size: 10)
    expect(f.name).to eq("times new russ")
    expect(f.weight).to eq(:bold)
    expect(f.size).to eq(10)
  end

  it "has a PaperSize class" do
    ps = Rendering::PaperSize.new(name: "A0", width: 841, height: 1189)
    expect(ps.name).to eq("A0")
    expect(ps.width).to eq(841)
    expect(ps.height).to eq(1189)
  end

  it "has default paper and font constants" do
    expect(Rendering::DEFAULT_FONT.name).to eq("comic sans")
    expect(Rendering::DEFAULT_PAPER_SIZE.name).to eq("A4")
  end

  it "is just an object" do
    the_module = Rendering

    times_new_roman_font = the_module::Font.new(name: 'times-new-roman')

    expect(times_new_roman_font.size).to eq(10)
  end
end

describe "Using Rendering" do
  it "it works with include" do
   expect do
     bp = BookPrinter.new
     bp.display_printing_defaults
   end.to output(/comic sans.*default.*297/m).to_stdout
  end
end
