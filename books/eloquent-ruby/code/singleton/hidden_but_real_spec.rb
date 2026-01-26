#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "getting hold of the singleton class" do
  let(:hand_built_printer_double) do
    hand_built_printer_double = Object.new

    def hand_built_printer_double.available?
      true
    end

    def hand_built_printer_double.render
      nil
    end

    hand_built_printer_double
  end

  it "lets you do it two ways" do
    singleton_class = class << hand_built_printer_double
      self
    end

    c1 = singleton_class
    
    singleton_class = hand_built_printer_double.singleton_class
    
    expect(c1).to be_kind_of(Class)
    expect(singleton_class).to be_kind_of(Class)
    expect(c1).to eq(singleton_class)
  end
end
