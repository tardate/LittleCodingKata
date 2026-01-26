#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "struct_doc_basic"

module WithDefineMethod
  class StructuredDocument < Basic::StructuredDocument; end

  # A better way.

  class StructuredDocument
    # Self is StructuredDocument here.
    
    def self.paragraph_type(name:, font:, font_size:)
      define_method(name) do |text|
        self << Paragraph.new(font:, font_size:, text:)
      end
    end
  end
end
