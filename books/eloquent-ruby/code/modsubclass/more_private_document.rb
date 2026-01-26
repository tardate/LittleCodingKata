#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "struct_doc_def_meth"

module MorePrivateDocument
  class StructuredDocument < WithDefineMethod::StructuredDocument; end

  class StructuredDocument
    # Rest of the class omitted...
  
    def self.disclaimer
      "This document is here for all to see."
    end
  
    def self.privatize
      private :content
  
      def self.disclaimer
        "This document is a deep, dark secret."
      end
    end
  end
end
