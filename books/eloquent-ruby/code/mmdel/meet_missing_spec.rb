#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

describe "Calling a bad method on document" do
  it "blows up" do
    doc = Document.new(title: "test", author: "russ", content: "hello world")
    expect do
      # This is bound to end badly!
      doc.text
    end.to raise_error(NoMethodError)
  end
end
