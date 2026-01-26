#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "method_parens"

RSpec.describe "method defined with parens" do
  include MethodWithParens

  it "works" do
    doc = find_the_doc
    expect(doc.title).to eq("Frankenstein")
    expect(doc.author).to eq("Shelley")
    expect(doc.content).to eq("content")
  end
end

