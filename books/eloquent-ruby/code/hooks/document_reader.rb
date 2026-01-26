#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

class DocumentReader

  class << self
    attr_accessor :reader_classes
  end

  @reader_classes = []

  def self.read(path)
    reader = reader_for(path)
    return nil unless reader

    reader.read(path)
  end

  def self.reader_for(path)
    reader_class = DocumentReader.reader_classes.find do |klass|
      klass.can_read?(path)
    end

    return reader_class.new(path) if reader_class
    nil
  end

  # One critical bit omitted, but stay tuned...
end

class DocumentReader
  # Most of the class omitted...

  # But here we have the vital missing piece.
  # When a class inherits from this we want to "register" it
  #
  def self.inherited(subclass)
    DocumentReader::reader_classes << subclass
  end
end
