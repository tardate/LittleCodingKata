#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module LittleAtATime
  module Rendering
    class PaperSize
      # Bulk of class omitted...
      def initialize(name: "A4", width: 210, height: 297)
      end
    end
  
    DEFAULT_PAPER_SIZE = PaperSize.new
  end
end
