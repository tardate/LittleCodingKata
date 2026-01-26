#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class SensitiveToRubyVersion
  if RUBY_VERSION > "3."
    # Do the right thing for a more recent Ruby version.
    # of Ruby. That might even be throw an exception.
  elsif RUBY_VERSION > "2."
    # Do the right thing if we are running in an earlier version
  else
    # You probably want the 1st edition of Eloquent Ruby.
  end 
end
