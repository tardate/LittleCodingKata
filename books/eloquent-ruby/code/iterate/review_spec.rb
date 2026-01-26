#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module BasicBlocks
  def do_something
    yield if block_given?
  end
end

describe "Basic behavior of blocks" do
  include BasicBlocks
  it "runs the block like a zero arg method" do
    expect do
      do_something do
        puts "Hello from inside the block"
      end
    end.to output(/Hello.*block/).to_stdout
    expect do
      do_something { puts "Hello from inside the block" }
    end.to output(/Hello.*block/).to_stdout
  end
end

describe "block arguments and return value" do
  it "Gets the argument passed in" do
    expect do
      def do_something_with_an_arg
        yield "Hello World" if block_given?
      end

      do_something_with_an_arg do |message|
        puts "The message is #{message}"
      end
    end.to output(/The.*Hello/).to_stdout
  end

  it "Gets the argument passed in" do
    expect do
      def print_the_value_returned_by_the_block
        if block_given?
          value = yield
          puts "The block returned #{value}"
        end
      end

      print_the_value_returned_by_the_block { 3.14159 / 4.0 }
    end.to output(/The block returned 0.785/).to_stdout
  end
end
