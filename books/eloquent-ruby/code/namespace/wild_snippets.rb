#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
See: https://github.com/ruby/rake/blob/2336a00b96b36c60185927dedda9481ba4a0f4c8/lib/rake.rb#L24

module Rake; end


See: https://github.com/ruby/rake/blob/2336a00b96b36c60185927dedda9481ba4a0f4c8/lib/rake/dsl_definition.rb#L5
module Rake
  ##
  # DSL is a module that provides #task, #desc, #namespace, etc.  Use this
  # when you'd like to use rake outside the top level scope.
  #
  # For a Rakefile you run from the command line this module is automatically
  # included.

  module DSL
    # Lots of code omitted...
  end
end

See: https://github.com/ruby/rake/blob/2336a00b96b36c60185927dedda9481ba4a0f4c8/lib/rake/linked_list.rb#L2C1-L8C29

module Rake
  # Polylithic linked list structure used to implement several data
  # structures in Rake.
  class LinkedList
    include Enumerable
    attr_reader :head, :tail

    # Even more code omitted...
  end
end


See: https://github.com/rack/rack/blob/ee7ac5a1db5bc5c65e4b83342b8f4df88ef3c075/lib/rack/multipart/uploaded_file.rb#L6

module Rack
  module Multipart
    # ...
    class UploadedFile
      # ...
    end
  end
end
=end
