#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "readonly_doc"

shared_examples "read only titles" do |doc_class|
  let(:ro_doc) {doc_class.new(author: "a", title: "Title", content: "")}

  it "refuses to change title if read_only is set" do
    ro_doc.title = "a new title"
    expect(ro_doc.title).to eq("Title")
  end
end

shared_examples "read only titles with exceptions" do |doc_class|
  let(:ro_doc) {doc_class.new(author: "a", title: "Title", content: "")}

  it "refuses to change title if read_only is set" do
    expect{ro_doc.title = "a new title"}.to raise_exception(Exception)
  end
end

shared_examples "read write titles" do |doc_class|
  let(:rw_doc) {doc_class.new(author: "a", title: "Title", content: "", read_only: false)}

  it "will change title if read_only is not set" do
    rw_doc.title = "a new title"
    expect(rw_doc.title).to eq("a new title")
  end
end

describe ReadOnlyDocument do
  include_examples "read only titles", ReadOnlyDocument
  include_examples "read write titles", ReadOnlyDocument
end

describe UnlessDocument do
  include_examples "read only titles", UnlessDocument
  include_examples "read write titles", UnlessDocument
end

describe UnlessModifierDocument do
  include_examples "read only titles", UnlessModifierDocument
  include_examples "read write titles", UnlessModifierDocument
end

describe UnlessElseDocument do
  include_examples "read only titles with exceptions", UnlessElseDocument
  include_examples "read write titles", UnlessElseDocument
end

describe IfElseDocument do
  include_examples "read only titles with exceptions", IfElseDocument
  include_examples "read write titles", IfElseDocument
end
