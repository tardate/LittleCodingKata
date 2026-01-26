#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document.rb"

module Constant
  class Document < ::Document; end

  class Document
    # Rest of the class omitted...

    if defined?(ENCRYPTION_ENABLED) and ENCRYPTION_ENABLED
      def encrypt(string) = string.tr("a-zA-Z", "m-za-lM-ZA-L")
    else
      def encrypt(string) = string
    end

    def save(path)
      open(path, "w") do |f|
        f.write("#{author}\n")
        f.write("#{title}\n")
        f.write(encrypt(content))
      end
    end

    # Loading and decryption left as an exercise for the reader...
  end
end
