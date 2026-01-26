#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "minitest/autorun"
require_relative "./printable_document"
require_relative "./printer"

describe Document do
  let(:doc) do
    PrintableDocument.new(title: "Test", author: "Russ", content: "A test")
  end

  it "lets you make a simple mock with Minitest::Mock" do
    # Create a mock with the available? and render methods.
  
    printer = Minitest::Mock.new
    printer.expect :available?, true
    printer.expect :render, :complete, ["A test"]

    # Do some printing...
    _(doc.print(printer)).must_equal :complete

    # And then verify that available? and render were actually called.
    printer.verify
  end
end

