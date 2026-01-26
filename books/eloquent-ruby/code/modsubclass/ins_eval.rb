#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "struct_doc_eval"

module WithClassEval
  class Instructions < StructuredDocument
    paragraph_type name: :introduction, font: :arial, font_size: 12
    paragraph_type name: :step, font: :arial, font_size: 10
    paragraph_type name: :warning, font: :mono, font_size: 14
  end
end
