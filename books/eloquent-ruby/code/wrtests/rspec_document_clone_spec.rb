#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "clonable_document"

RSpec.describe Document do
  it "should have a functional clone method" do
    doc1 = Document.new(title: "title", author: "author", content: "some stuff")
    doc2 = doc1.clone

    expect(doc1).to have_attributes(
      title: "title",
      author: "author",
      content: "some stuff"
    )
  end
end
