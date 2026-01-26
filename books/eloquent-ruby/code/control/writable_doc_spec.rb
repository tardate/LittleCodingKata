#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "writable_doc"


module WritableDocument
  shared_examples "writable titles" do |doc_class|
    let(:ro_doc) {doc_class.new(author: "a", title: "Title", content: "")}
    let(:rw_doc) {doc_class.new(author: "a", title: "Title", content: "", writable: true)}

    it "refuses to change title if writeable is not set" do
      ro_doc.title = "a new title"
      expect(ro_doc.title).to eq("Title")
    end

    it "will change title if writeable is set" do
      rw_doc.title = "a new title"
      expect(rw_doc.title).to eq("a new title")
    end

  end

  describe Document do
    include_examples "writable titles", Document
  end

  describe IfModifierDocument do
    include_examples "writable titles", IfModifierDocument
  end
end
