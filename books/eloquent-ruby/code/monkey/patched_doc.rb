#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative '../common/document'

module BadAvgWordLen
  class Document < ::Document; end

  class Document
    def average_word_length
      total_length = words.sum(&:size)
      total_length.fdiv(word_count)
    end
  end
end

module SaferAvgWordLen
  class Document < BadAvgWordLen::Document; end

  class Document
    def average_word_length
      return 0.0 if word_count.zero?
  
      total_length = words.sum(&:size)
      total_length.fdiv(word_count)
    end
  end
end
