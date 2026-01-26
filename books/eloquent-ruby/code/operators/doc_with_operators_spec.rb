#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_operators"

module WithOperators
  describe Document do
    it "supports document addition" do
      expect do
        doc1 = Document.new(
          title: "Tag Line1",
          author: "Kirk",
          content: "These are the voyages")

        doc2 = Document.new(
          title: "Tag Line2",
          author: "Kirk",
          content: "of the star ship ...")

        total_document = doc1 + doc2
        puts total_document.content
      end.to output(/These.*star ship/).to_stdout
    end

    it "support word indexing" do
      doc = Document.new(
        title: "Tag Line1",
        author: "Kirk",
        content: "These are the voyages")

      words = %w[These are the voyages]
      words.each_with_index { |w, i| expect(w).to eq(doc[i]) }
      expect(doc.size).to eq(4)
    end

    it "lets you do silly negation" do
      favorite = Document.new(
        title: "Favorite",
        author: "Russ",
        content: "Chocolate is best")

      expect((!favorite).content).to eq("It is not true: Chocolate is best")
    end

    it "lets you do silly unary plus and minus" do
      favorite = Document.new(
        title: "Favorite",
        author: "Russ",
        content: "Chocolate is best")

      unsure = -(+favorite)

      expect(unsure.content).to match(/I doubt that I am sure that Choc/)
    end
  end
end

module DocPlusString
  describe Document do
    it "lets you add a string to a document" do
      doc = Document.new(title: "hi", author: "russ", content: "Hello")
      new_doc = doc + "out there!"
      expect(new_doc).to be_a(Document)
      expect(new_doc.content).to match(/Hello out there!/)
    end

    it "blows up if you switch the order" do
      doc = Document.new(title: "hi", author: "russ", content: "Hello ")
      expect do
        "I say to you, " + doc
      end.to raise_error(TypeError)
    end
  end
end

module NewConstructor
  describe Document do
    it "lets you create a document from words" do
      doc = Document["To", "be", "or", "not"]
      expect(doc.content).to eq("To be or not")
      expect(doc.author).to eq("author")
      expect(doc.title).to eq("title")
    end
  end
end
