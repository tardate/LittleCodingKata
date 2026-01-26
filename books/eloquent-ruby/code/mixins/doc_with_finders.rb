#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"
require_relative "finders"

module ClassInclude
  class Document < ::Document; end

  class Document
    # Most of the class omitted...

    class << self
      include Finders
    end
  end
end

module Extend
  class Document < ::Document; end

  class Document
    extend Finders

    # Most of the class omitted...
  end
end
