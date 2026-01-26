#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "private_document"

module PrivateDocument
  class Brochure < StructuredDocument
    paragraph_type name: :hype, font: :comic_sans, font_size: 50
  end

  class BankStatement < StructuredDocument
    paragraph_type name: :overdrawn, font: :arial, font_size: 20

    privatize
  end
  
  describe Brochure do
    it "has a public content method" do
      expect(Brochure.public_instance_methods).to include(:content)
    end
  end

  describe BankStatement do
    it "has a private content method" do
      expect(BankStatement.private_instance_methods).to include(:content)

      expect do
      statement = BankStatement.new(title: "Bank Statement", author: "Russ")
      statement.overdrawn("You're broke!")
      puts statement.content
      end.to raise_error(NoMethodError)
    end
  end
end
