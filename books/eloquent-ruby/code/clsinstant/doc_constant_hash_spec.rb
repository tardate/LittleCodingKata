#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module ConstantHash
  class Document
    # The constant CONFIG is constant, but the hash is not.
    CONFIG = {default_font: :times}
    # ...

    def self.config_set(name, value)
      CONFIG[name] = value
    end

    def self.config_get(name)
      CONFIG[name]
    end
  end

  describe "using a constant/not really hash" do
    it "works is the best you can say" do
      Document.config_set(:default_font, :times)
      expect(Document.config_get(:default_font)).to eq(:times)
      Document.config_set(:default_font, :comic_sans)
      Document.config_set(:default_font, :nimbus)
      expect(Document.config_get(:default_font)).to eq(:nimbus)
    end
  end
end
