#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module RelatedDocs
  class BaseDocument
    def content
      raise "Not Implemented"
    end

    def words
      raise "Not Implemented"
    end

    def word_count
      raise "Not Implemented"
    end

    # And so on for the author, author=,
    # title and so on...
  end

  class Document < BaseDocument
    attr_accessor :title, :author, :content

    def initialize(title:, author:, content:)
      @title = title
      @author = author
      @content = content
    end

    def content
      @content
    end

    def words
      @content.split
    end

    def word_count
      words.size
    end
  end

  class LazyDocument < BaseDocument
    attr_writer :title, :author, :content

    def initialize(path:)
      @path = path
      @document_read = false
    end

    def read_document
      return if @document_read
      File.open(@path) do |f|
        @title = f.readline.chomp
        @author = f.readline.chomp
        @content = f.read
      end
      @document_read = true
    end

    def content
      read_document
      @content
    end

    def words
      read_document
      @content.split
    end

    # And so on...
  end

  class LazyDocument
    def author
      read_document
      @author
    end

    def title
      read_document
      @title
    end
  end
end
