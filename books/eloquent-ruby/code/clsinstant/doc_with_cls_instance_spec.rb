#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_cls_instance"

module ClassInstance
  describe "Presentation Document independence" do
    it "means we can set the Document default and have it stick" do
      Document.default_font = :arial
      expect(Document.default_font).to eq(:arial)
    end

    it "means you can change the document default font w/o affecting presentation" do
      Presentation.default_font = :arial
      Document.default_font = :fixed

      expect(Presentation.default_font).to eq(:arial)
      expect(Document.default_font).to eq(:fixed)

      Presentation.default_font = :times
      expect(Document.default_font).to eq(:fixed)
    end

  end
end

module ConvenientClassInstance
  describe Document do
    it "has default font accessors" do
      expect(Document.default_font).to eq(:times)
      Document.default_font = :comic_sans
      expect(Document.default_font).to eq(:comic_sans)
    end
  end
end

