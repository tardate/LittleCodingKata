#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "doc_class_method"

module ClassMethod
  describe "Document with a class method" do
    let(:book) do
      book = Document.create_test_document(length: 10000)
    end

    it "has the class method" do
      expect(book.title).to eq("test")
      expect(book.author).to eq("Nobody")
      expect(book.content[0]).to eq("A")
      expect(book.content.length).to eq(10000)
    end

    it "does not have the instance method" do
      expect do
        longer_doc = book.create_test_document(20000)
      end.to raise_error(NoMethodError)
    end

    it "lets you get access via the class of the instance" do
      longer_doc = book.class.create_test_document(length: 20000)
      expect(longer_doc.title).to eq("test")
      expect(longer_doc.author).to eq("Nobody")
    end
  end
end
