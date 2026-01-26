#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "best_compressor"

module TroubledCompressor
  class TextCompressor < BestCompressor::TextCompressor; end

  class TextCompressor
    # ...

    def add_unique_word(word)
      add_word_to_unique_array(word)
      last_index_of_unique_array
    end

    def add_word_to_unique_array(word)
      @unique << word
    end

    def last_index_of_unique_array
      unique.size - 1
    end
  end
end

