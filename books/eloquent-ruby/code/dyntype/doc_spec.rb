#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc"

describe Doc do
  it "Works in a cryptic sort of way" do
    doc = Doc.new("Emma", "Austen", "Emma Woodhouse, handsome...")
    expect(doc.t).to eq("Emma")
    expect(doc.a).to eq("Austen")
    expect(doc.wds).to eq(%w(Emma Woodhouse, handsome...))
    expect(doc.wc).to eq(3)
  end
end
