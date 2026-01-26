#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "rawk_1"

module Version2
  class Rawk < Version1::Rawk; end

  class Rawk
    # Most of the class omitted...

    def initialize(&block)
      @actions = []
      if block
        instance_eval &block
      end
    end
  end
end
