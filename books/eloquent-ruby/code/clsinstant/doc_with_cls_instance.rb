#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module ClassInstance
  class Document < ::Document; end

  class Document
    @default_font = :times
  
    def self.default_font=(font)
      @default_font = font
    end
  
    def self.default_font
      @default_font
    end
  
    # Rest of the class omitted...
  end


  class Document
    # Rest of the class omitted...
 
    def initialize(title:, author:, content:)
      @title = title
      @author = author
      @content = content
      @font = Document.default_font
    end
   end


  class Presentation < Document
    @default_font = :nimbus
  
    def self.default_font=(font)
      @default_font = font
    end
  
    def self.default_font
      @default_font
    end
  
    def initialize(title:, author:, content:)
      @title = title
      @author = author
      @content = content
      @font = Presentation.default_font
    end
  
    # most of the class omitted...
  end
 
end

module ConvenientClassInstance
  class Document < ::Document; end

  class Document
    @default_font = :times
    
    class << self
      attr_accessor :default_font
    end
  
    # Rest of the class omitted...
  end
end
