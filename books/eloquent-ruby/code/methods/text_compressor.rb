#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module BasicCompressor
  class TextCompressor
    attr_reader :unique, :index, :text

    def initialize(text:)
      @text = text
      @unique = []
      @index = []

      words = text.split
      words.each do |word|
        i = @unique.index(word)
        if i
          @index << i
        else
          @unique << word
          @index << unique.size - 1
        end
      end
    end
  end
end
