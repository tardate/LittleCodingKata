#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "more_private_document"

module MorePrivateDocument
  class BankStatement < StructuredDocument
    paragraph_type name: :overdrawn, font: :arial, font_size: 20

    privatize
  end
   
  describe StructuredDocument do
    it "has a public disclaimer method" do
      expect(StructuredDocument.disclaimer).to match(/here for all./)
    end
  end

  describe BankStatement do
    it "has a private disclaimer method" do
      expect(BankStatement.disclaimer).to match(/dark secret./)
    end
  end
end
