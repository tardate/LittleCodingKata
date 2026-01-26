#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "document_identifier"
require_relative "document_pointer"

module Broaden
  DocumentIdentifier = KindOf::DocumentIdentifier

  describe DocumentPointer do
    it "has a working == method" do
      id1 =  DocumentPointer.new(folder: "contracts", name: "Book Deal")
      id2 =  DocumentPointer.new(folder: "contracts", name: "Book Deal")
      id3 =  DocumentPointer.new(folder: "somewhere", name: "Book Deal")
      id4 =  DocumentPointer.new(folder: "contracts", name: "something")

      expect(id1 == id1).to be_truthy
      expect(id3 == id3).to be_truthy

      expect(id1 == id2).to be_truthy
      expect(id2 == id1).to be_truthy

      expect(id1 == id3).to be_falsey
      expect(id1 == id3).to be_falsey

      expect(id3 == id2).to be_falsey
      expect(id4 == id2).to be_falsey
    end

    it "has doc_p == x works for x with .folder and .name methods" do
      expect do
        doc_id =  DocumentIdentifier.new(folder: "secret/area51", name: "plans.txt")
        doc_p =  DocumentPointer.new(folder: "secret/area51", name: "plans.txt")

        puts "They are equal!" if doc_p == doc_id
      end.to output(/equal!/).to_stdout
    end

    it "has x == doc_p doesn't work even for x with .folder and .name methods" do
      expect do
        doc_id =  DocumentIdentifier.new(folder: "secret/area51", name: "plans.txt")
        doc_p =  DocumentPointer.new(folder: "secret/area51", name: "plans.txt")

        puts "They are equal!" if doc_id == doc_p
      end.to output("").to_stdout
    end
 end
end
