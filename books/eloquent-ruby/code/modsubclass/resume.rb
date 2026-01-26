#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "struct_doc_basic"
require_relative "paragraph"

module Basic
  class Resume < StructuredDocument
    def name(text)
      self << Paragraph.new(font: :arial, font_size: 14, text:)
    end
  
    def address(text)
      self << Paragraph.new(font: :arial, font_size: 12, text:)
    end
  
    def email(text)
      self << Paragraph.new(font: :mono, font_size: 10, text:)
    end

    def body(text)
      self << Paragraph.new(font: :arial, font_size: 12, text:)
    end
  end
end
