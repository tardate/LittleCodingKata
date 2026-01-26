#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "paragraph"
require_relative "struct_doc_basic"

module Basic
  describe StructuredDocument do
    it "lets you add paragraphs" do
      russ_cv = StructuredDocument.new(title: "Resume", author: "RO") do |cv|
        cv << Paragraph.new(font: :arial, font_size: 18, text: "Russ Olsen")
        cv << Paragraph.new(font: :arial, font_size: 12, text: "1313 Mocking Bird Ln")
        cv << Paragraph.new(font: :roboto, font_size: 12, text: "russ@russolsen.com")

        # ...and so on
      end
      expect(russ_cv.title).to eq("Resume")
      expect(russ_cv.author).to eq("RO")
      expect(russ_cv.content).to match(/Russ.*1313.*olsen.com/m)

      expect(russ_cv.paragraphs[0].font_size).to eq(18)
      expect(russ_cv.paragraphs[1].text).to match(/Mocking/)
      expect(russ_cv.paragraphs[2].font).to eq(:roboto)
    end
  end
end
