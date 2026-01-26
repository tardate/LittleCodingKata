#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "paragraph"

module Basic
  class StructuredDocument
    attr_accessor :title, :author, :paragraphs

    def initialize(title:, author:, &block)
      @title = title
      @author = author
      @paragraphs = []

      block.call(self) if block
    end

    def <<(paragraph)
      @paragraphs << paragraph
    end

    def content = @paragraphs.join("\n")
  end
end
