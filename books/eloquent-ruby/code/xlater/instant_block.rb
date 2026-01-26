#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "doc_with_listeners"

module DocWithPointyListeners
  class Document < BlockListeners::Document; end

  class Document
    def initialize(title:, author:, content: "")
      @title = title
      @author = author
      @content = content

      # Note the use of -> instead of lambda.

      @load_listener = -> doc, path do
        puts "Loaded #{doc.title} from #{path}"
      end

      # -> works with parentheses and braces as well!
      @save_listener = ->(doc, path) { puts "Saved #{doc.title}" }
    end
  end
end

module DocWithLambdaListeners
  class Document < BlockListeners::Document; end

  class Document
    def initialize(title:, author:, content: "")
      @title = title
      @author = author
      @content = content

      @load_listener = lambda do |doc, path|
        puts "Loaded #{doc.title} from #{path}"
      end

      @save_listener = lambda do |doc, path|
        puts "Saved #{doc.title} to #{path}"
      end
    end
  end
end
