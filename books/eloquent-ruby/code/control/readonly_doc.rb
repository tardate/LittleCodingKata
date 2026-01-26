#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class ReadOnlyDocument
  attr_accessor :read_only 
  attr_reader :title, :author, :content 

  def initialize(title:, author:, content:, read_only: true)
    @read_only = read_only
    @title = title
    @author = author
    @content = content
  end

  def title=(new_title) 
    if !@read_only 
      @title = new_title 
    end 
  end 
end

class UnlessDocument < ReadOnlyDocument
  def title=(new_title)
    unless @read_only 
      @title = new_title 
    end
  end 
end

class UnlessModifierDocument < ReadOnlyDocument
  def title=(new_title) 
  #
    @title = new_title unless @read_only 
  end 
end

class UnlessElseDocument < ReadOnlyDocument
  # Nope!
  def title=(new_title) 
    unless @read_only
      @title = new_title
    else
      raise "Can't modify a readonly document!"
    end
  end
end

class IfElseDocument < ReadOnlyDocument
  # Better.
  def title=(new_title) 
    if @read_only
      raise "Can't modify a readonly document!"
    else
      @title = new_title
    end
  end
end
