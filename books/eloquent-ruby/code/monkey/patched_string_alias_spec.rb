#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe String do
  # We do this crazy load here to ensure that we have
  # the right version of our String monkey patching.
  # Did I mention you have to be careful about modifying
  # the core classes?
  
  load "patched_string_alias.rb"

  it 'can append a document' do
    doc = Document.new(title: "Test", author: "Russ", content: "456")
    result = "123" + doc
    expect(result).to be_a(Document)
    expect(result.title).to eq(doc.title)
    expect(result.author).to eq(doc.author)
    expect(result.content).to eq("123456")
  end
end

