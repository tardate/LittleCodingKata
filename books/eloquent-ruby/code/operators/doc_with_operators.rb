#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

module WithOperators
  class Document < ::Document; end

  class Document
    # Most of the class omitted...
    #
    def +(other)
      Document.new(
        title: title, 
        author: author, 
        content: "#{content} #{other.content}")
    end
  end

  class Document
    # Stuff omitted...

    def ! 
      Document.new(
        title: title,
        author: author, 
        content: "It is not true: #{content}")
    end
  end

  class Document
    # Most of the class taking a break...

    def +@
      Document.new(
        title: title,
        author: author,
        content: "I am sure that #{@content}")
    end

    def -@
      Document.new(
        title: title,
        author: author,
        content: "I doubt that #{@content}")
    end
  end


  class Document
    # Most of the class omitted...
    def [](index)
      words[index]
    end
  end

  class Document
    def size
      words.size
    end
  end
end

module DocPlusString
  class Document < WithOperators::Document; end

  class Document
    def +(other)
      if other.kind_of?(String)
        new_content = "#{content} #{other}"
      else
        new_content = "#{content} #{other.content}"
      end

      return Document.new(
        title: title, 
        author: author, 
        content: new_content)  
    end
  end
end

module NewConstructor
  class Document < DocPlusString::Document; end

  class Document
    def self.[](*words)
      # Create a new document whose contents consist of all of the words
      # joined together, separated by a space.
      new(author: "author", title: "title", content: words.join(" "))
    end
  end
end
