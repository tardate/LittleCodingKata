#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "mocks and doubles" do
  it "allows you to create a fake object with methods" do
    printer_double = double(available?: true, render: nil)

    expect(
      printer_double.available?       # Always returns true.
    ).to be_truthy

    expect(
      printer_double.render           # Always returns nil.
    ).to be_nil

    fake_font = double(size: 14, name: 'Courier')

    expect do
      puts fake_font.class
      puts printer_double.class
    end.to output(/RSpec::Mocks::Double.*Double/m).to_stdout
  end
end

describe "singleton methods" do
  it "allows you to build your own mock object" do
    hand_built_printer_double = Object.new

    def hand_built_printer_double.available?
      true
    end

    def hand_built_printer_double.render
      nil
    end

    expect(hand_built_printer_double.available?).to be_truthy
    expect(hand_built_printer_double.render).to be_nil
  end

  it "allows you to override regular methods" do
    expect do
      uncooperative = "Don't ask my class"

      def uncooperative.class
        "I'm not telling"
      end

      puts uncooperative.class
    end.to output(/not telling/).to_stdout
  end

  it "supports an alternative syntax" do
    hand_built_printer_double = Object.new

    class << hand_built_printer_double
      def available?  # A singleton method
        true
      end

      def render      # Another one
        nil
      end
    end
    expect(hand_built_printer_double.available?).to be_truthy
    expect(hand_built_printer_double.render).to be_nil
  end
end

