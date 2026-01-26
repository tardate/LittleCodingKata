#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# See: https://github.com/ruby/ruby/blob/88d71eb04da9de34495c4cffcd2e234dd9ec96f9/lib/uri/http.rb#L12

module URI
  # Stuff omitted...

  class HTTP < Generic
    # Lots of HTTP uri related code omitted.
  end
end

# See: https://github.com/ruby/ruby/blob/88d71eb04da9de34495c4cffcd2e234dd9ec96f9/lib/uri/ftp.rb#L12

module URI
  # ...
  class FTP < Generic
    # Lots of FTP uri related code omitted.
  end
end

See:  https://github.com/rails/rails/blob/fc6608728d00331237237113e310da0b0c37b648/activesupport/lib/active_support/core_ext/string/filters.rb#L21

class String
  # ...

  # Performs a destructive squish. See String#squish.
  #   str = " foo   bar    \n   \t   boo"
  #   str.squish!                         # => "foo bar boo"
  #   str                                 # => "foo bar boo"
  def squish!
    gsub!(/[[:space:]]+/, " ")
    strip!
    self
  end

  # ...
end

See:  https://github.com/rails/rails/blob/fc6608728d00331237237113e310da0b0c37b648/activesupport/lib/active_support/core_ext/array/access.rb#L54

class Array
  # ...

  # Equal to <tt>self[1]</tt>.
  #
  #   %w( a b c d e ).second # => "b"
  def second
    self[1]
  end

  # Equal to <tt>self[2]</tt>.
  #
  #   %w( a b c d e ).third # => "c"
  def third
    self[2]
  end

  # And so on...
end

# See: https://github.com/rails/rails/blob/fc6608728d00331237237113e310da0b0c37b648/activesupport/lib/active_support/core_ext/array/access.rb#L83
#
  # Equal to <tt>self[41]</tt>. Also known as accessing "the reddit".
  #
  #   (1..42).to_a.forty_two # => 42
  def forty_two
    self[41]
  end
=end
