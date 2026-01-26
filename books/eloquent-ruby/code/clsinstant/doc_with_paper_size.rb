#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module WithPaperSize
  class Document < ::Document; end

  class Document
    @@default_paper_size = :a4
  
    def self.default_paper_size
      @@default_paper_size
    end
    def self.default_paper_size=(new_size)
      @@default_paper_size = new_size
    end
    
    attr_accessor :title, :author, :content
    attr_accessor :paper_size
    
    def initialize(title:, author:, content:)
      @title = title
      @author = author
      @content = content
      @paper_size = @@default_paper_size
    end
    # Rest of the class omitted...
  end
end
