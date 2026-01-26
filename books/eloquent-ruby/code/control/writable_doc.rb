#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module WritableDocument
  class Document
    attr_accessor :writable 
    attr_reader :title, :author, :content 

    def initialize(title:, author:, content:, writable: false)
      @writable = writable
      @title = title
      @author = author
      @content = content
    end


    # Much of the class omitted... 

    def title=(new_title) 
      if @writable 
        @title = new_title 
      end 
    end 

    # Similar author= and content= methods omitted... 
  end


  class IfModifierDocument < Document
    def title=(new_title) 
      @title = new_title  if @writable 
    end 
  end
end
