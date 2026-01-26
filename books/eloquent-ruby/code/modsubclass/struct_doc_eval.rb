#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "struct_doc_basic"

module WithClassEval
  class StructuredDocument < Basic::StructuredDocument; end

  class StructuredDocument
    def self.paragraph_type(name:, font:, font_size:)
      # What do we do in here?
    end
  end


  class StructuredDocument
    # Keep reading! There's a better way to do this!

    def self.generate_code(name:, font:, font_size:)
      %Q{
        def #{name}(text)
          p = Paragraph.new(font: :#{font}, font_size: #{font_size}, text:)
          self << p
        end
      }
    end

    def self.paragraph_type(name:, font:, font_size:)
      code = generate_code(name:, font:, font_size:)
      class_eval(code)
    end
  end
end
