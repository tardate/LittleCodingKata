#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "printable_doc"

shared_examples "print method" do |method_name|
  let(:doc) {PrintableDocument.new(author: "a", title: "Title", content: "")}

  it "prints correctly with the given method" do
    expect(doc.page_count).to be > 0
    expect(doc.pages_printed).to eq(0)
    self.send(method_name, doc)
    expect(doc.pages_printed).to eq(doc.page_count)
  end
end

describe "it works" do
  include_examples "print method", :print_doc_with_while
  include_examples "print method", :print_doc_with_until
  include_examples "print method", :print_doc_with_while_modifier
  include_examples "print method", :print_doc_with_until_modifier
end