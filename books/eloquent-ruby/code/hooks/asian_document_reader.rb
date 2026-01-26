#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "document_reader"

  class AsianDocumentReader < DocumentReader
    # Lots of code for dealing with Asian languages
    def self.can_read?(path)
      false
    end
  end
  
  class JapaneseDocumentReader < AsianDocumentReader
    # Lots of stuff omitted
  end
  
  class ChineseDocumentReader < AsianDocumentReader
    # Lots of stuff omitted
  end
