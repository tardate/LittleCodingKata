#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "marketing_message"

module Basic
  describe MarketingMessage do
    it "customizes junk mail" do
      offer_letter = MarketingMessage.new(
        title: "Special Offer",
        author: "Acme Inc",
        content: <<~LETTER
      Dear TITLE LASTNAME,

      Are you troubled by the heartache of hangnails?
      ...

      FIRSTNAME, we look forward to hearing from you.
        LETTER
      )

      offer_letter.replace_word("TITLE", "Mr.")
      offer_letter.replace_word("FIRSTNAME", "Russ")
      offer_letter.replace_word("LASTNAME", "Olsen")

      content = offer_letter.content
      expect(content).to match(/Dear Mr\. Olsen.*Russ, we look/m)
    end
  end
end


module WithMM
  describe MarketingMessage do
    it "lets you make up method names" do
      letter = MarketingMessage.new(
        title: "Example", 
        author: "Acme", 
        content: "NAME PRODUCT PRICE"
      )
      letter.replace_name("AAA")
      letter.replace_product("BBB")
      letter.replace_price("999")
      letter.replace_nothing("ZZZ")

      expect(letter.content).to match(/^AAA BBB 999$/)
      expect(letter.content).to_not match(/ZZZ/)
    end

    it "throws an exception on certain magic method method names" do
      expect do
        letter = MarketingMessage.new(
          title: "Example", 
          author: "Acme", 
          content: "The  word is WORD"
        )
        letter.replace_word("Abracadabra")
      end.to raise_exception(ArgumentError)
    end

    it "has a proper responds_to? implementation" do
      letter = MarketingMessage.new(
        title: "Example", 
        author: "Acme", 
        content: "The  word is WORD"
      )
      expect(letter.respond_to?(:replace_age)).to be_truthy
      expect(letter.respond_to?(:replace_foo)).to be_truthy
      expect(letter.respond_to?(:replace_bar)).to be_truthy

      expect(letter.respond_to?(:replace_)).to be_falsey
      expect(letter.respond_to?(:rep_foo)).to be_falsey
      expect(letter.respond_to?(:abc)).to be_falsey
    end
  end
end
