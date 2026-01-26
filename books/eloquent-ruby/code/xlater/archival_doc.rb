#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

class ArchivalDocument
  attr_reader :title, :author

  def initialize(title:, author:, path:)
    @title = title
    @author = author
    @path = path
  end

  def content
    @content ||= File.read(@path)
  end
end

class BlockBasedArchivalDocument
  attr_reader :title, :author

  def initialize(title:, author:, &block_function)
    @title = title
    @author = author
    @initializer_block = block_function
  end

  def content
    if @initializer_block
      @content = @initializer_block.call
      @initializer_block = nil
    end

    @content
  end
end
