#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module RepeatYourself
  class Document
    # Not a great idea to repeat the class name.
    def Document.create_test_document(length:)
      # ...
    end

    def Document.create_short_test_document
      # ...
    end

    def Document.create_long_test_document
      # ...
    end
  end
end

module DontRepeatYourself
  class Document
    # Define a single class method.
    def self.create_test_document(length:)
      # ...
    end

    # Or define a bunch of class methods
    class << self
      def create_short_test_document
        # ...
      end

      def create_long_test_document
        # ...
      end
    end
  end
end

module RepeatYourself
  describe Document do
    it "has the class method" do
      Document.create_test_document(length: 999)
    end
  end
end

module DontRepeatYourself
  describe Document do
    it "has the class method" do
      Document.create_test_document(length: 999)
      Document.create_short_test_document
      Document.create_long_test_document
    end
  end
end
