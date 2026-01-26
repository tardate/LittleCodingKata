#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document.rb"

module MissingEncryptClassMethodCall
  class Document < ::Document; end

  # Look for the subtle flaw...
  class Document
    # Something very important missing here...

    def self.enable_encryption(enabled)
      if enabled
        def encrypt(string) = string.tr("a-zA-Z", "m-za-lM-ZA-L")
      else
        def encrypt(string) = string
      end
    end

    # Rest of our boring Document class...
  end
end

module MispelledMethod
  class Document < ::Document; end

  class Document
    def self.enable_encryption(enabled)
      if enabled
        def encrypt(string) = string.tr("a-zA-Z", "m-za-lM-ZA-L")
      else
        def incrypt(string) = string
      end
    end

    enable_encryption(true)

    # Rest of our boring Document class omitted...
  end
end
