#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "struct_doc_eval"


module WithClassEval
  class TwoParagraphs < StructuredDocument
    paragraph_type name: :p1, font: :roboto, font_size: 10
    paragraph_type name: :p2, font: :freesans, font_size: 18
  end

  describe StructuredDocument do
    it "generates pragraph method code" do
      name = :introduction
      font = :roboto
      font_size = 12
      code = StructuredDocument.generate_code(name:, font:, font_size:)

      expect(code).to match(/def introduction\(text\).*end$/m)
    end
  end

  describe TwoParagraphs do
    it "has the two class methods" do
      expect(TwoParagraphs.instance_methods).to include(:p1)
      expect(TwoParagraphs.instance_methods).to include(:p2)
    end

    it "generates the proper paragraphs" do
      doc = TwoParagraphs.new(title: "Test", author: "Russ") do |doc|
        doc.p1("This is p1")
        doc.p2("This is p2")
      end

      expect(doc.paragraphs.size).to eq(2)
      expect(doc.paragraphs[0].font).to eq(:roboto)
      expect(doc.paragraphs[0].font_size).to eq(10)
      expect(doc.paragraphs[1].font).to eq(:freesans)
      expect(doc.paragraphs[1].font_size).to eq(18)
    end
  end
end
