#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "prism"

describe Prism do
  it "produces a LOT of data for hello world" do
    pat = Regexp.new(".*\n" * 30)
    expect do
      code = 'print("Hello world!")'
      ast = Prism.parse(code)
      pp ast
    end.to output(pat).to_stdout
  end

  it "produces a LOT of data for our example" do
    pat = Regexp.new(".*\n" * 100)
    expect do
      code = File.read("trivial_example.rb")
      ast = Prism.parse(code)
      pp ast
    end.to output(pat).to_stdout
  end
end
