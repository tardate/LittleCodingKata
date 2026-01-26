#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module BetterCompressor
  class TextCompressor
    attr_reader :unique, :index

    def initialize(text:)
      @unique = []
      @index = []

      words = text.split
      words.each do |word|
        i = unique_index_of(word)
        if i
          @index << i
        else
          @index << add_unique_word(word)
        end
      end
    end

    def unique_index_of(word)
      @unique.index(word)
    end

    def add_unique_word(word)
      @unique << word
      unique.size - 1
    end
  end
end
